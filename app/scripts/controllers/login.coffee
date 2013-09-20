@angular.module("soSlotControlMasterApp").
  controller("LoginCtrl", ['$rootScope', '$scope', '$timeout', '$location', 'SlotCarService', ($rootScope, $scope, $timeout, $location, SlotCarService) ->
    $scope.serverUrl = "http://localhost:12345"

    $scope.$watch('SlotCarService.loginState')

    $scope.loginService = SlotCarService

    $scope.login = (serverUrl, password) ->
      SlotCarService.connect(serverUrl, password).then(->
        $location.path('/')
        $scope.$apply()
      )
  ])