@app.controller "ProjectController", ($scope, Restangular, $routeParams) ->
  Restangular.one('projects', $routeParams.id).get().then (project) ->
    $scope.project = project
