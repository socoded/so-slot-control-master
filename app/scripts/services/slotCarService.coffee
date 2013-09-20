'use strict';

class SlotCarConnection
  constructor: (@service, @serverUrl, @password, @deferred) ->
    @serverUrl += "/master"
    @socket = window.io.connect(@serverUrl)

    @socket.on 'authentication-challenge', @authenticate

    @socket.on 'authentication-failed', @authenticationFailed
    @socket.on 'authentication-success', @authenticationSuccessful

    @socket.on 'devices-list', @updateDevicesList
    @socket.on 'status-update', @updateStatus
    @socket.on 'overrides-update', @updateOverrides
    @socket.on 'angle-config-update', @updateAngleConfig

  authenticate: =>
    @socket.emit('authentication-response', password: @password)

  authenticationFailed: =>
    @service.authenticationFailed()
    @deferred.reject()

  authenticationSuccessful: =>
    @service.authenticationSuccessful()
    @getStatus()
    @getOverrides()
    @listDevices()
    @getAngleConfig()

    @deferred.resolve(@)

  getOverrides: =>
    @socket.emit('get-overrides')

  getStatus: =>
    @socket.emit('get-status')

  listDevices: =>
    @socket.emit('list-devices')

  getAngleConfig: =>
    @socket.emit('get-angle-config')

  setup: (device) =>
    @socket.emit('setup', device: device)

  updateDevicesList: ({@devices}) =>
    @service.rootScope.$apply()

  updateStatus: ({@ready}) =>
    @service.rootScope.$apply()

  updateOverrides: ({@overrides}) =>
    @service.rootScope.$apply()

  updateAngleConfig: ({@angleConfig}) =>
    @service.rootScope.$apply()

  override: (controller) =>
    @socket.emit('override', controller: controller)

  release: (controller) =>
    @socket.emit('release', controller: controller)

  setAngle: (controller, angle) =>
    @socket.emit('set-angle', controller: controller, angle: angle)

  reconnect: =>
    @socket.emit('reconnect')

  setMax: (controller, angle) =>
    @socket.emit('set-max', controller: controller, angle: angle)

  setMin: (controller, angle) =>
    @socket.emit('set-min', controller: controller, angle: angle)

  resetAngleSettings: =>
    @socket.emit('reset-angle-settings')

class SlotCarService
  constructor: (@rootScope, @timeout) ->

  connect: (serverUrl, password) =>
    deferred = D()
    @loginState = 'loading'
    $.getScript("#{serverUrl}/socket.io/socket.io.js", =>
      @loginState = 'authenticating'
      @connection = new SlotCarConnection(@, serverUrl, password, deferred)
    )

    @timeout((=> (@serverNotFound() and deferred.reject()) if @loginInProgress()), 2000)

    deferred.promise

  loginInProgress:-> @loginState is 'loading'
  isServerNotFound: -> @loginState is 'serverNotFound'
  wrongPassword: -> @loginState is 'wrongPassword'
  authenticating: -> @loginState is 'authenticating'
  loggedIn: -> @loginState is 'loggedIn'

  disconnect: =>
    delete @loginState
    delete @rootScope.connected

  authenticationSuccessful: =>
    @loginState = 'loggedIn'
    @rootScope.connected = true
    @rootScope.$apply()

  authenticationFailed: =>
    @loginState = 'wrongPassword'
    @rootScope.$apply()

  serverNotFound: =>
    @loginState = 'serverNotFound'

angular.module('soSlotControlMasterApp')
  .service 'SlotCarService', ['$rootScope', '$timeout', ($rootScope, $timeout) ->
    new SlotCarService($rootScope, $timeout)
  ]