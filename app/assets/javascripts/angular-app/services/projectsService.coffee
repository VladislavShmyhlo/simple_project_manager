@app.service 'Projects', (Restangular) ->
  Restangular.extendCollection 'projects', (collection) ->
    collection.getAllWithTasks = ->
      @getList().then (projects) ->
        angular.forEach projects, (pr) ->
          Restangular.restangularizeCollection(pr, pr.tasks, 'tasks')
        projects
    collection

  Restangular.extendModel 'projects', (model) ->
    model.updateName = ->
      @patch(name: @name)
    model

  Restangular.all 'projects'
