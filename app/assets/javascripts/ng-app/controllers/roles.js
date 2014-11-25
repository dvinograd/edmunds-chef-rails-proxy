angular.module('myApp')
  .controller('RolesCtrl', function($scope, $http) {
    $http.get('/api/v1/roles')
      .success(function(data, status, headers, config) {
        $scope.roles = data;
      })
      .error(function(data, status, headers, config) {
        $scope.roles = ['Call to /api/v1/roles failed']
      });
  });
