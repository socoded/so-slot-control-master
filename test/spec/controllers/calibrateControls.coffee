'use strict'

describe 'Controller: CalibratecontrolsCtrl', () ->

  # load the controller's module
  beforeEach module 'soSlotControlMasterApp'

  CalibratecontrolsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    CalibratecontrolsCtrl = $controller 'CalibratecontrolsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
