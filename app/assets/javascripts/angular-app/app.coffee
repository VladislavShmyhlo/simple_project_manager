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
  $routeProvider.when "/", {
    templateUrl: 'home.html',
    controller: 'ProjectsController'
  }
  $routeProvider.when '/login', {
    templateUrl: 'login.html'
  }
  $routeProvider.when '/projects/:project_id/tasks/:id', {
    templateUrl: 'task.html'
    controller: 'TaskController'
  }
#  $routeProvider.otherwise {
#    redirectTo: '/'
#  }
)
.run(->
  console.log 'APP RUNNING'
)