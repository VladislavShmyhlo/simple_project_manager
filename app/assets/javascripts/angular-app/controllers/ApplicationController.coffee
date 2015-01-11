@app.controller "ApplicationController", ($rootScope, $scope, Restangular, $location) ->
  loadingStatus = (st) ->
    $rootScope.$broadcast 'load', {active: st}

  Restangular.setErrorInterceptor (response, deferred, responseHandler) ->
    loadingStatus(false)
    if response.status is 401
      $location.path('/login')
      return false
    else
      console.log "error #{response.status}"

  Restangular.addFullRequestInterceptor ->
    loadingStatus(true)
    return
  Restangular.addResponseInterceptor (data) ->
    console.log 'done.'
    loadingStatus(false)
    data

  $scope.removeItem = (item, collection) ->
    collection.destroy(item)


  $scope.editing = {
    itemNewName: null
    editedItem: null
  }

  $scope.beginItemEdit = (item) ->
    $scope.editing.itemNewName = item.name
    $scope.editing.editedItem = item

  $scope.cancelItemEdit = ->
    $scope.editing.editedItem = null

  $scope.confirmItemEdit = (item) ->
    item.name = $scope.editing.itemNewName
    item.updateName().then ->
      $scope.cancelItemEdit()