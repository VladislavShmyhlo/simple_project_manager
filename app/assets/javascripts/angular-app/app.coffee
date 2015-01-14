# for compatibility with Rails CSRF protection

@app = angular.module('exampleApp', [
  'restangular'
  'templates'
  'ngRoute'
  'ui.sortable'
])
.config((RestangularProvider) ->
  RestangularProvider.setDefaultHeaders {
    'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')
    'Accept': 'application/json'
  }
)
.config(($routeProvider) ->
  $routeProvider.when "/", {
    templateUrl: 'projects.html',
    controller: 'ProjectsController'
  }
  $routeProvider.when '/projects/:project_id/tasks/:id', {
    templateUrl: 'task.html'
    controller: 'TaskController'
  }
  $routeProvider.when '/projects/:id', {
    templateUrl: 'project.html'
    controller: 'ProjectController'
  }
  $routeProvider.when '/login', {
    templateUrl: 'login.html'
    controller: 'LoginController'
  }
  $routeProvider.otherwise {
    redirectTo: '/'
  }
)
.run((Restangular)->

  _modelMethods = (model) ->
    model.updateName = ->
      self = @
      @patch(name: @name).then (item)->
        _.extend(self, item)
    model

  _collectionMethods = (collection) ->
    collection.create = (item) ->
      self = @
      @post(item).then (item) ->
        self.unshift(item)
    collection.destroy = (item)->
      self = @
      item.remove().then ->
        _.pull(self, item)
    collection

  _positionMethods = (item) ->
    item.updateTasks = ->
      @patch(project: {tasks_attributes: @tasks})
    item

  Restangular.extendModel 'projects', _modelMethods
  Restangular.extendModel 'projects', _positionMethods
  Restangular.extendModel 'tasks', _modelMethods
  Restangular.extendModel 'comments', _modelMethods
  Restangular.extendModel 'attachments', _modelMethods
  Restangular.extendCollection 'projects', _collectionMethods
  Restangular.extendCollection 'tasks', _collectionMethods
  Restangular.extendCollection 'comments', _collectionMethods
  Restangular.extendCollection 'attachments', _collectionMethods

  Restangular.addResponseInterceptor (data, operation, what, url) ->
    if operation is 'get' and what is 'tasks'
      Restangular.restangularizeElement(null, data, 'tasks')
      Restangular.restangularizeCollection(data, data.comments, 'comments')
      angular.forEach data.comments, (comment) ->
        # cant find any solution except custom post to force 'attachments'
        # collection to post to comments/:comment_id/attachments/:id
        Restangular.restangularizeCollection(comment, comment.attachments, 'attachments')
      data
    else if operation is 'getList' and what is 'projects'
      Restangular.restangularizeCollection(null, data, 'projects')
      angular.forEach data, (pr) ->
        Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
      data
    else data

  console.log 'APP RUNNING'
)