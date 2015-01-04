@app.controller "TasksController", ($scope, Projects) ->
  $scope.tasks = $scope.project.tasks

  $scope.createNewTask = (item, collection) ->
    item.completed = false
    collection.post(item).then (item) ->
      collection.push(item)
      console.log 'task created'

  $scope.taskClass = (item) ->
    return 'completed' if item.completed

  $scope.updateTask = (item) ->
    item.patch().then ->
      console.log('task updated')

  $scope.removeTask = (item, collection) ->
    item.remove()
    .then ->
      index = collection.indexOf(item)
      if (index > -1) then collection.splice(index, 1)
    .then ->
      console.log 'task removed'