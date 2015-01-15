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

  # TODO: remove update name methods from models which does not have name attribute
  _modelMethods = (model) ->
    model.updateAttr = (attr)->
      self = @
      newItem = {}
      newItem[attr] = @[attr]
      @patch(newItem).then (item)->
        _.extend(self, item)
    model

  _collectionMethods = (collection) ->
    # post item and push it to collection
    # @param {Object} item
    collection.create = (item) ->
      self = @
      @post(item).then (item) ->
        self.unshift(item)
    # destroy item and remove it from collection
    # @params {Object} item
    collection.destroy = (item)->
      self = @
      item.remove().then ->
        _.pull(self, item)
    collection

  _positionMethods = (item) ->
    # update project's tasks
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
      _.forEach data.comments, (comment) ->
        # cant find any solution except custom post to force 'attachments'
        # collection to post to comments/:comment_id/attachments/:id
        Restangular.restangularizeCollection(comment, comment.attachments, 'attachments')
      data
    else if operation is 'getList' and what is 'projects'
      Restangular.restangularizeCollection(null, data, 'projects')
      _.forEach data, (pr) ->
        Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
      data
    else data

  console.log 'APP RUNNING'
)