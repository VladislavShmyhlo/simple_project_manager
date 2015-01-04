@app.controller "ProjectsController", ($scope, Restangular) ->
  $scope.data = {
    projectNewName: null
    editedProject: null
  }
  updateProject = (item) ->
    item.patch({name: item.name}).then ->
      console.log 'project updated'

  Project = Restangular.all 'projects'
  Project.getList().then (projects) ->
    console.log projects
    angular.forEach projects, (pr) ->
      Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
    $scope.projects = projects


  $scope.createNewTask = (item, collection) ->
    item.completed = false
    collection.post(item).then (item) ->
      console.log item
      collection.push(item)

  $scope.removeItem = (item, collection) ->
    item.remove().then ->
      index = collection.indexOf(item)
      if (index > -1) then collection.splice(index, 1)

  $scope.taskClass = (item) ->
    return 'completed' if item.completed

  $scope.updateTask = (item) ->
    item.patch().then ->
      console.log('task updated')

#  project editing:

  $scope.beginProjectEdit = (item, form) ->
    $scope.data.projectNewName = item.name
    $scope.data.editedProject = item

  $scope.cancelProjectEdit = ->
    $scope.data.editedProject = null;

  $scope.confirmProjectEdit = (item) ->
    item.name = $scope.data.projectNewName
    updateProject(item).then ->
      $scope.cancelProjectEdit()