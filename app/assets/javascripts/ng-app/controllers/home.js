angular.module('myApp')
    .controller('HomeCtrl', function ($scope, Restangular) {
        $scope.things = ['Angular', 'Rails 4.1', 'UI Router', 'Together!!'];
    });
