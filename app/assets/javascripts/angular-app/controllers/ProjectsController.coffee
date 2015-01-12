@app.controller "ProjectsController", ($scope, Restangular) ->

  projects = Restangular.all 'projects'

  projects.getList().then (projects) ->
    console.log projects
    $scope.projects = projects

