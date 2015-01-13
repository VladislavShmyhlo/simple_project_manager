@app.controller "TasksController", ($scope) ->
  $scope.tasks = $scope.project.tasks

  $scope.sortableOptions = {
    forcePlaceholderSize: true
    placeholder: 'task-ph'
    stop: (e, d)->
      a = d.item.parent().sortable('toArray', {attribute: 'data-id'})
      a = _.invert(a)
      res = []
      for k,v of a
        res.push({id: k, position: v})
      _.forEach res, (item) ->
        _.forEach $scope.tasks, (task) ->
          if _.parseInt(item.id) is _.parseInt(task.id)
            _.extend task, item
      $scope.project.updateTasks()
  }

  $scope.createNewTask = (item, collection) ->
    item.completed = false
    collection.create(item).then ->
      $scope.newTask = {}

  $scope.taskClass = (item) ->
    return 'done' if item.completed

  $scope.updateTask = (item) ->
    item.patch()