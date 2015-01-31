@app.controller "ProjectsController", ($scope, Restangular) ->
  $scope.newProject = {}
  $scope.creatingNewProject = false
  projects = Restangular.all 'projects'

  projects.getList().then (projects) ->
    $scope.projects = projects

  $scope.addNewProject = ->
    $scope.creatingNewProject = true
    $scope.newProject = {}

  $scope.createNewProject = (item, collection) ->
    $scope.createNewItem(item, collection).then ->
      $scope.cancelNewProject()

  $scope.cancelNewProject = ->
    $scope.creatingNewProject = false
    $scope.newProject = {}
