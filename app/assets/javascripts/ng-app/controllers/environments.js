angular.module('myApp')
  .controller('EnvironmentsCtrl', function($scope, $http) {
    $http.get('/api/v1/environments')
      .success(function(data, status, headers, config) {
        $scope.environments = data;
      })
      .error(function(data, status, headers, config) {
        $scope.environments = ['Call to /api/v1/environments failed']
      });
  });
