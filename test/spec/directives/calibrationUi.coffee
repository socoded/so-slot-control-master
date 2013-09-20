'use strict'

describe 'Directive: calibrationUi', () ->

  # load the directive's module
  beforeEach module 'soSlotControlMasterApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<calibration-ui></calibration-ui>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the calibrationUi directive'
