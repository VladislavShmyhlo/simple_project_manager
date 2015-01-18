# for compatibility with Rails CSRF protection

@app = angular.module('exampleApp', [
  'restangular'
  'templates'
  'ngRoute'
  'ui.sortable'
  'ui.date'
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
#  $routeProvider.when '/login', {
#    templateUrl: 'login.html'
#    controller: 'LoginController'
#  }
  $routeProvider.otherwise {
    redirectTo: '/'
  }
)
.run((Restangular)->

  _modelMethods = (model) ->
    # update model's attribute
    # @param {String} attr
    model.updateAttr = (attr)->
      updatedItem = {}
      updatedItem[attr] = @[attr]
      @patch(updatedItem).then (item) =>
        _.extend(@, item)
    model

  _positionMethods = (item) ->
    # update project's tasks
    item.updateTasks = ->
      @patch(project: {tasks_attributes: @tasks})
    item

  _collectionMethods = (collection) ->
    # post item and push it to collection
    # @param {Object} item
    collection.create = (item) ->
      @post(item).then (item) =>
        @unshift(item)
    # destroy item and remove it from collection
    # @params {Object} item
    collection.destroy = (item)->
      item.remove().then =>
        _.pull(@, item)
    collection

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
    # add restangular methods to comment and comment.attachments
    # after creating new comment
    if operation is 'post' and what is 'comments'
      Restangular.restangularizeElement null, data, 'comments'
      Restangular.restangularizeCollection data, data.attachments, 'attachments'
      return data
    # add restangular methods to task, task.comments and comment.attachments
    # after retrieving single task
    if operation is 'get' and what is 'tasks'
      Restangular.restangularizeElement(null, data, 'tasks')
      Restangular.restangularizeCollection(data, data.comments, 'comments')
      _.forEach data.comments, (comment) ->
        Restangular.restangularizeCollection(Restangular.one('comments', comment.id), comment.attachments, 'attachments')
      return data
    # add restangular methods to projects and project.tasks
    # after retrieving list of projects
    else if operation is 'getList' and what is 'projects'
      Restangular.restangularizeCollection(null, data, 'projects')
      _.forEach data, (pr) ->
        Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
      return data
    else
      return data

  console.log 'APP RUNNING'
)