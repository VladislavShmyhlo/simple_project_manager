@app.controller "TasksController", ($scope) ->
  $scope.tasks = $scope.project.tasks
  $scope.sortableOptions = {
    forcePlaceholderSize: true
    placeholder: 'tst'
    update: (e, d)->
      console.log d.item.parent().sortable('toArray', {attribute: 'data-id'})
  }
  $scope.createNewTask = (item, collection) ->
    item.completed = false
    collection.create(item)

  $scope.taskClass = (item) ->
    return 'done' if item.completed

  $scope.updateTask = (item) ->
    item.patch().then ->