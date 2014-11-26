angular.module('myApp')
  .controller('EnvironmentsCtrl', function($scope, $http) {
    $http.get('/api/v1/environments')
      .success(function(data, status, headers, config) {
        $scope.environments = data;
      })
      .error(function(data, status, headers, config) {
        $scope.environments = ['Call to /api/v1/environments failed']
      });

    $scope.showEnvironment = function(name, chefsrv) {
      var url_path = '/api/v1/environments/' + name + '?chef-server=' + chefsrv + '&format=text'
      $http.get(url_path)
        .success(function(data, status, headers, config) {
          BootstrapDialog.show({ message: '<div><pre>' + data + '</pre></div>' });
        })
        .error(function(data, status, headers, config) {
          BootstrapDialog.show({ message: '<div>Call to ' + url_path + ' failed</div>' });
        });
    };

    $scope.showEnvironmentDiff = function(name, chefsrv1, chefsrv2) {
      var url_path = '/api/v1/diff/environment?name=' + name + '&chef-server-1=' + chefsrv1 + '&chef-server-2=' + chefsrv2 + '&format=text'
      $http.get(url_path)
        .success(function(data, status, headers, config) {
          BootstrapDialog.show({ message: '<div><pre>' + data + '</pre></div>' });
        })
        .error(function(data, status, headers, config) {
          BootstrapDialog.show({ message: '<div>Call to ' + url_path + ' failed</div>' });
        });
    };
  });
