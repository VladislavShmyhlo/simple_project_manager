@app.service 'projectsService', (Restangular) ->

  _modelMethods = (model) ->
    model.updateName = ->
      self = @
      @patch(name: @name).then (item)->
        _.extend(self, item)
    model

  _collectionMethods = (collection) ->
    collection.create = (item) ->
      self = @
      @.post(item).then (item) ->
        self.push(item)
    collection.destroy = (item)->
      self = @
      item.remove().then ->
        _.pull(self, item)
    collection

  Restangular.extendModel 'projects', _modelMethods
  Restangular.extendModel 'tasks', _modelMethods
  Restangular.extendModel 'comments', _modelMethods
  Restangular.extendCollection 'projects', _collectionMethods
  Restangular.extendCollection 'tasks', _collectionMethods
  Restangular.extendCollection 'comments', _collectionMethods

  Restangular.addResponseInterceptor (data, operation, what, url) ->
    if operation is 'get' and what is 'tasks'
      Restangular.restangularizeElement(null, data, 'tasks')
      Restangular.restangularizeCollection(data, data.comments, 'comments')
      data
    else if operation is 'getList' and what is 'projects'
      Restangular.restangularizeCollection(null, data, 'projects')
      angular.forEach data, (pr) ->
        Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
      data
    else data

  Restangular