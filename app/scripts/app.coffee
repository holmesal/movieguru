'use strict'

app = angular.module('movieguruApp', [])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'

# Hacky way to force CORS to work
app.config ['$httpProvider', ($httpProvider) ->
	$httpProvider.defaults.useXDomain = true
	delete $httpProvider.defaults.headers.common['X-Requested-With']
]
