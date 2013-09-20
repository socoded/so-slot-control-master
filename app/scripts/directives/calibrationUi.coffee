'use strict';

angular.module('soSlotControlMasterApp')
  .directive('calibrationUi', () ->
    templateUrl: "views/_calibration_ui.html"
    restrict: 'E'
    scope:
      controller: '='
  )