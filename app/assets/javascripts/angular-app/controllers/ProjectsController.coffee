@app.controller "ProjectsController", ($scope, Projects) ->
  $scope.data = {
    projectNewName: null
    editedProject: null
  }

  Projects.getAllWithTasks().then (projects) ->
    $scope.projects = projects


  $scope.createNewTask = (item, collection) ->
    item.completed = false
    collection.post(item).then (item) ->
      collection.push(item)
      console.log 'task created'

  $scope.removeItem = (item, collection) ->
    item.remove().then ->
      console.log 'task removed'
      index = collection.indexOf(item)
      if (index > -1) then collection.splice(index, 1)

  $scope.taskClass = (item) ->
    return 'completed' if item.completed

  $scope.updateTask = (item) ->
    item.patch().then ->
      console.log('task updated')

#  project editing:

  $scope.beginProjectEdit = (item) ->
    $scope.data.projectNewName = item.name
    $scope.data.editedProject = item

  $scope.cancelProjectEdit = ->
    $scope.data.editedProject = null;

  $scope.confirmProjectEdit = (item) ->
    item.name = $scope.data.projectNewName
    item.updateName()
    .then ->
      console.log 'project updated'
    .then ->
      $scope.cancelProjectEdit()