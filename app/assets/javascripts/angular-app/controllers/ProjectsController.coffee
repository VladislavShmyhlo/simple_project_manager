@app.controller "ProjectsController", ($scope, Restangular) ->
  Project = Restangular.all 'projects'
  Project.getList().then (projects) ->
    angular.forEach projects, (pr) ->
      Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
    $scope.projects = projects