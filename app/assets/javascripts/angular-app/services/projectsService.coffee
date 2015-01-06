@app.service 'Projects', (Restangular) ->
  Restangular.extendCollection 'projects', (collection) ->
    collection.getAllWithTasks = ->
      @getList().then (projects) ->
        angular.forEach projects, (pr) ->
          Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
        projects
    collection

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
  Restangular.extendCollection 'projects', _collectionMethods
  Restangular.extendCollection 'tasks', _collectionMethods


  Restangular.all 'projects'
