@app.controller "ProjectsController", ($scope, projectsService) ->
  $scope.data = {
    projectNewName: null
    editedProject: null
  }
  projects = projectsService.all 'projects'

  projects.getList().then (projects) ->
    $scope.projects = projects

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