@app.controller "TasksController", ($scope) ->
  $scope.tasks = $scope.project.tasks

  $scope.sortableOptions = {
    forcePlaceholderSize: true
    placeholder: 'task-ph'
    handle: '.handle'
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

      $scope.project.updateTasks().then ->
  }

  $scope.createNewTask = (item, collection) ->
    pos = (_.min collection, (task) ->
      _.parseInt(task.position)).position
    item.position = --pos
    item.completed = false
    collection.create(item).then ->
      $scope.newTask = {}

  $scope.taskClass = (item) ->
    return 'done' if item.completed

  $scope.updateTask = (item) ->
    item.patch()