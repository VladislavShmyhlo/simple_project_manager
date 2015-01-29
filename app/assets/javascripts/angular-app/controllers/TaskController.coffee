@app.controller 'TaskController', ($location, $scope, $routeParams, Restangular) ->
  task = Restangular.one('projects', $routeParams.project_id).one('tasks', $routeParams.id)

  task.get().then (task) ->
    console.log task
    $scope.task = task

  $scope.removeTask = (item) ->
    item.remove().then ->
      $location.path($scope.task.project.getRestangularUrl())

  $scope.attachment = {}
  $scope.createAttachment = (file, collection)->
    data = new FormData()
    data.append('attachment[file]', file)
    collection.withHttpConfig({transformRequest: angular.identity}).post(data, {}, {'Content-Type': undefined})
    .then (res)->
      collection.unshift res