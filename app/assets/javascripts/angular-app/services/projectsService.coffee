@app.service 'Projects', (Restangular) ->
  Restangular.extendCollection 'projects', (collection) ->
    collection.getAllWithTasks = ->
      @getList().then (projects) ->
        angular.forEach projects, (pr) ->
          Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
        projects
    collection

  update = (model) ->
    model.updateName = ->
      self = @
      @patch(name: @name).then (res)->
        _.extend(self, res)
    model

  Restangular.extendModel 'projects', update
  Restangular.extendModel 'tasks', update

  Restangular.all 'projects'
