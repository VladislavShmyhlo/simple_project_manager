@app.controller 'TaskController', ($location, $scope, $routeParams, projectsService) ->
  task = projectsService.one('projects', $routeParams.project_id).one('tasks', $routeParams.id)

  task.get().then (data) ->
    $scope.task = data

  $scope.removeTask = (item) ->
    item.remove().then ->
      $location.path('/')