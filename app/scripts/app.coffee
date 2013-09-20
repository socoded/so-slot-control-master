@angular.module("soSlotControlMasterApp", []).config(($routeProvider) ->
  $routeProvider.when("/",
    templateUrl: "views/main.html"
    controller: "MainCtrl"
  ).when("/login",
    templateUrl: "views/login.html"
    controller: "LoginCtrl"
  ).when("/calibrate-controls",
    templateUrl: "views/calibrate_controls.html"
    controller: "CalibrateControlsCtrl"
  ).otherwise redirectTo: "/"
).run ($rootScope, $location) ->
  $rootScope.$on "$routeChangeStart", (event, next, current) ->
    $location.path "/login" if next.templateUrl isnt "views/login.html" and !$rootScope.connected

    $rootScope.activeTab = 'calibrateControls' if next.templateUrl is "views/calibrate_controls.html"
