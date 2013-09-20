'use strict'

describe 'Controller: NavigationCtrl', () ->

  # load the controller's module
  beforeEach module 'soSlotControlMasterApp'

  NavigationCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    NavigationCtrl = $controller 'NavigationCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
