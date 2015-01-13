@app.controller "TasksController", ($scope) ->
  $scope.tasks = $scope.project.tasks

  $scope.sortableOptions = {
    forcePlaceholderSize: true
    placeholder: 'task-ph'
    stop: (e, d)->
      a = d.item.parent().sortable('toArray', {attribute: 'data-id'})
      console.log a
      a = _.invert(a)
      $scope.project.updateTasksPosition(a)
  }

  $scope.createNewTask = (item, collection) ->
    item.completed = false
    collection.create(item)

  $scope.taskClass = (item) ->
    return 'done' if item.completed

  $scope.updateTask = (item) ->
    item.patch()