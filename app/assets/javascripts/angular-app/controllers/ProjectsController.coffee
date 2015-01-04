@app.controller "ProjectsController", ($scope, Projects) ->
  $scope.data = {
    projectNewName: null
    editedProject: null
  }

  Projects.getAllWithTasks().then (projects) ->
    $scope.projects = projects

  $scope.removeProject = (item, collection) ->
    item.remove()
    .then ->
      index = collection.indexOf(item)
      if (index > -1) then collection.splice(index, 1)
    .then ->
      console.log 'project removed'

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
      $scope.cancelProjectEdit()
    .then ->
      console.log 'project updated'