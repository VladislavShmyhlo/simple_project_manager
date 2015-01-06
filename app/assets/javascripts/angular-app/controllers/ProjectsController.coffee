@app.controller "ProjectsController", ($scope, Projects) ->
  $scope.data = {
    projectNewName: null
    editedProject: null
  }

  Projects.getAllWithTasks().then (projects) ->
    $scope.projects = projects

  $scope.removeProject = (item, collection) ->
    collection.destroy(item)

#  project editing:

  $scope.beginProjectEdit = (item) ->
    $scope.data.projectNewName = item.name
    $scope.data.editedProject = item

  $scope.cancelProjectEdit = ->
    $scope.data.editedProject = null;

  $scope.confirmProjectEdit = (item) ->
    item.name = $scope.data.projectNewName
    item.updateName().then ->
      $scope.cancelProjectEdit()