@app.controller 'TaskController', ($location, $scope, $routeParams, Restangular) ->
  task = Restangular.one('projects', $routeParams.project_id).one('tasks', $routeParams.id)

  task.get().then (data) ->
    console.log data
    $scope.task = data

  $scope.removeTask = (item) ->
    item.remove().then ->
      $location.path('/')

  $scope.attachment = {}
  $scope.createAttachment = (file, collection)->
    data = new FormData()
    data.append('attachment[file]', file)
    console.log data

    collection.withHttpConfig({transformRequest: angular.identity}).post(data, {}, {'Content-Type': undefined}).then (res)->
      console.log res