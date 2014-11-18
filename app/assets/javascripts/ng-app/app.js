angular
    .module('myApp', [
        'ngAnimate',
        'ui.router',
        'restangular',
        'templates'
    ])
    .config(function ($stateProvider, $urlRouterProvider, $locationProvider) {
        /**
         * Routes and States
         */
        $stateProvider
            .state('home', {
                url: '/',
                templateUrl: 'home.html',
                controller: 'HomeCtrl'
            })
            // an abstract state that just serves as a
            // parent for the below child states
            .state('dashboard', {
                abstract: true,
                url: '/dashboard',
                templateUrl: 'dashboard/layout.html'
            })
                // the default route when someone hits dashboard
                .state('dashboard.environments', {
                    url: '',
                    templateUrl: 'dashboard/environments.html'
                })
                // this is /dashboard/roles
                .state('dashboard.roles', {
                    url: '/roles',
                    templateUrl: 'dashboard/roles.html'
                })
                // this is /dashboard/cookbooks
                .state('dashboard.cookbooks', {
                    url: '/cookbooks',
                    templateUrl: 'dashboard/cookbooks.html'
                });

        // default fall back route
        $urlRouterProvider.otherwise('/');

        // enable HTML5 Mode for SEO
        $locationProvider.html5Mode(true);
    });
