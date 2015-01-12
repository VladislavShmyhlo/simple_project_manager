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
        self.unshift(item)
    collection.destroy = (item)->
      self = @
      item.remove().then ->
        _.pull(self, item)
    collection

  _orderMethods = (collection) ->
    collection.updateOrder = (hash) ->
      res = []
      for k,v of hash
        res.push({id: k, order: v})
      res
    collection

  Restangular.extendModel 'projects', _modelMethods
  Restangular.extendModel 'tasks', _modelMethods
  Restangular.extendModel 'comments', _modelMethods
  Restangular.extendModel 'attachments', _modelMethods
  Restangular.extendCollection 'projects', _collectionMethods
  Restangular.extendCollection 'tasks', _collectionMethods
  Restangular.extendCollection 'tasks', _orderMethods
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

  Restangular