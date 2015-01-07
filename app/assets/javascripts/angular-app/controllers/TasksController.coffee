@app.controller "TasksController", ($scope) ->
  $scope.tasks = $scope.project.tasks

  $scope.createNewTask = (item, collection) ->
    item.completed = false
    collection.create(item)

  $scope.taskClass = (item) ->
    return 'done' if item.completed

  $scope.updateTask = (item) ->
    item.patch().then ->