@app.controller "TasksController", ($scope) ->
  $scope.tasks = $scope.project.tasks

  $scope.sortableOptions = {
    forcePlaceholderSize: true
    placeholder: 'task-ph'
    handle: '.handle'
    stop: (e, d)->
      a = d.item.parent().sortable('toArray', {attribute: 'data-id'})
      res = []
      _.forEach a, (id, i) ->
        res.push({id: id, position: i})
      console.log _.map($scope.tasks, (t)-> t.id)
      console.log _.map(res, (t)-> t.id)
#      _.forEach res, (item) ->
#        task = _.where($scope.tasks, {id: _.parseInt(item.id)})[0]
#        _.extend task, item

#      $scope.project.updateTasks()
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