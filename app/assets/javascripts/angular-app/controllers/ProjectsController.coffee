@app.controller "ProjectsController", ($scope, Restangular) ->
  Project = Restangular.all 'projects'
  Project.getList().then (data) ->
    $scope.projects = data