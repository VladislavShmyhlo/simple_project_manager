@app.controller "TasksController", ($scope) ->
  $scope.tasks = $scope.project.tasks
  $scope.newTask = {}
  $scope.sortableOptions = {
    forcePlaceholderSize: true
    placeholder: 'task-ph'
    handle: '.handle'
    stop: (e, d)->
      a = d.item.parent().sortable('toArray', {attribute: 'data-id'})
      res = []
      _.forEach a, (id, i) ->
        res.push({id: _.parseInt(id), position: i})
      _.forEach res, (item) ->
        task = _.where($scope.tasks, {id: item.id})[0]
        task.position = item.position
      $scope.project.updateTasks()
  }
  $scope.datepickerOptions = {
    dateFormat: 'dd/mm/yy',
    showOn: 'both'
    buttonText: ''
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