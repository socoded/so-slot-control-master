'use strict'

angular.module('soSlotControlMasterApp')
  .controller 'NavigationCtrl', ['$scope', 'SlotCarService', ($scope, SlotCarService) ->
    $scope.logout = ->
      SlotCarService.disconnect()
  ]
