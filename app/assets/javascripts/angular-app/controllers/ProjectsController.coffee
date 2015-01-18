@app.controller "ProjectsController", ($scope, Restangular) ->
  $scope.newProject = {}
  projects = Restangular.all 'projects'

  projects.getList().then (projects) ->
    console.log projects
    $scope.projects = projects