@app.controller "ProjectController", ($scope, Restangular) ->

  project = Restangular.one('projects', 16)

  project.get().then (project) ->
    console.log project
    $scope.project = project

