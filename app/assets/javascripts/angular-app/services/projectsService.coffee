@app.service 'Projects', (Restangular) ->
  Restangular.extendCollection 'projects', (collection) ->
    collection.getAllWithTasks = ->
      @getList().then (projects) ->
        angular.forEach projects, (pr) ->
          Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
        projects
    collection

  updateName = (model) ->
    model.updateName = ->
      self = @
      @patch(name: @name).then (item)->
        _.extend(self, item)
    model

  create = (collection) ->
    collection.create = (item) ->
      self = @
      @.post(item).then (item)->
        self.push(item)
    collection

  Restangular.extendModel 'projects', updateName
  Restangular.extendModel 'tasks', updateName
  Restangular.extendCollection 'projects', create
  Restangular.extendCollection 'tasks', create


  Restangular.all 'projects'
