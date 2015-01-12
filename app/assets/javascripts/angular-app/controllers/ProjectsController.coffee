@app.controller "ProjectsController", ($scope, projectsService) ->

  projects = projectsService.all 'projects'

  projects.getList().then (projects) ->
    console.log projects
    $scope.projects = projects

