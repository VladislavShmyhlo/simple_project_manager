# for compatibility with Rails CSRF protection

@app = angular.module('exampleApp', [
  'restangular'
  'templates'
  'ngRoute'
])
.config((RestangularProvider) ->
  RestangularProvider.setDefaultHeaders {
    'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')
    'Accept': 'application/json'
  }
)
.config(($routeProvider) ->
  $routeProvider.when("/", {
    templateUrl: 'home.html'
  })
  $routeProvider.when('/login', {
    templateUrl: 'login.html'
  })
  $routeProvider.otherwise({
    redirectTo: '/'
  })
)
.run(->
  console.log 'APP RUNNING'
)