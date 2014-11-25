angular.module('myApp')
  .controller('CookbooksCtrl', function($scope, $http) {
    $http.get('/api/v1/cookbooks')
      .success(function(data, status, headers, config) {
        $scope.cookbooks = data;
      })
      .error(function(data, status, headers, config) {
        $scope.cookbooks = ['Call to /api/v1/cookbooks failed']
      });
  });
