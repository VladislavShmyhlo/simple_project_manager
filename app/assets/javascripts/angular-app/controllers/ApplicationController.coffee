@app.controller "ApplicationController", ($rootScope, $scope, Restangular, $location) ->
  loadingStatus = (st) ->
    $rootScope.$broadcast 'loading', {active: st}

  Restangular.setErrorInterceptor (response) ->
    loadingStatus(false)
    if response.status is 401
      $location.path('/login')
      return false

  Restangular.addFullRequestInterceptor ->
    loadingStatus(true)

  Restangular.addResponseInterceptor (data) ->
    loadingStatus(false)
    console.log 'done.'
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