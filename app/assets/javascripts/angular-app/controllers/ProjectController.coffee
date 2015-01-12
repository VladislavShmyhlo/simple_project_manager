@app.controller "ProjectController", ($scope, Restangular) ->

  project = Restangular.one('projects', 3)

  project.get().then (project) ->
    console.log project
    $scope.project = project

