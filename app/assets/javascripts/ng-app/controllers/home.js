angular.module('myApp')
    .controller('HomeCtrl', function ($scope, Restangular) {
        //$scope.things = ['Angular', 'Rails 4.1', 'UI Router', 'Together!!'];
        $scope.things = Restangular.all('roles').get('local-web').$object;
    });
