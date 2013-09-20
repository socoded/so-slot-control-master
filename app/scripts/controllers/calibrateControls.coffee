'use strict'

angular.module('soSlotControlMasterApp')
  .controller 'CalibrateControlsCtrl', ['$scope', 'SlotCarService', ($scope, SlotCarService) ->
    $scope.controllers = SlotCarService.connection

    $scope.setupControllers = (device) ->
      SlotCarService.connection.setup(device)
  ]
