@app.controller "ApplicationController", ($rootScope, $scope, Restangular, $location) ->
  loadingStatus = (st) ->
    $rootScope.$broadcast 'loading', {active: st}

  Restangular.setErrorInterceptor (response) ->
    loadingStatus(false)
    if response.status is 401
      window.location = 'users/sign_in'
#      $location.path('/login')
#      return false

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

#  $scope.aniClass = ''
#  $scope.anim = 'fx-fade-up fx-spped-600 fx-easing-quad'

  $scope.createNewItem = (item, collection) ->
    collection.create(item).then ->
      delete item[k] for k,v of item

  $scope.beginItemEdit = (item, attr) ->
    $scope.editing.itemNewAttr = item[attr]
    $scope.editing.editedItem = item

  $scope.cancelItemEdit = ->
    $scope.editing.editedItem = null

  $scope.confirmItemEdit = (item, attr) ->
    item[attr] = $scope.editing.itemNewAttr
    item.updateAttr(attr).then(->
      $scope.cancelItemEdit()
    ,(data) ->
      console.log data
    )

  $scope.logout = ->
    Restangular.all('users').customDELETE 'sign_out'
    window.location = 'users/sign_in'
