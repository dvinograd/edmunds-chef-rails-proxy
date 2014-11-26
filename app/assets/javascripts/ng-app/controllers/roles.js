angular.module('myApp')
  .controller('RolesCtrl', function($scope, $http) {
    $http.get('/api/v1/roles')
      .success(function(data, status, headers, config) {
        $scope.roles = data;
      })
      .error(function(data, status, headers, config) {
        $scope.roles = ['Call to /api/v1/roles failed']
      });

    $scope.showRole = function(name, chefsrv) {
      var url_path = '/api/v1/roles/' + name + '?chef-server=' + chefsrv + '&format=text'
      $http.get(url_path)
        .success(function(data, status, headers, config) {
          BootstrapDialog.show({ message: '<div><pre>' + data + '</pre></div>' });
        })
        .error(function(data, status, headers, config) {
          BootstrapDialog.show({ message: '<div>Call to ' + url_path + ' failed</div>' });
        });
    };

    $scope.showRoleDiff = function(name, chefsrv1, chefsrv2) {
      var url_path = '/api/v1/diff/role?name=' + name + '&chef-server-1=' + chefsrv1 + '&chef-server-2=' + chefsrv2 + '&format=text'
      $http.get(url_path)
        .success(function(data, status, headers, config) {
          BootstrapDialog.show({ message: '<div><pre>' + data + '</pre></div>' });
        })
        .error(function(data, status, headers, config) {
          BootstrapDialog.show({ message: '<div>Call to ' + url_path + ' failed</div>' });
        });
    };
  });
