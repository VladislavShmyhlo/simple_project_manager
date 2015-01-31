@app.controller "ApplicationController", ($rootScope, $scope, Restangular, $location) ->
  loadingStatus = (st) ->
    $rootScope.$broadcast 'loading', {active: st}
  auth = (st) ->
    $scope.authenticated = st

  Restangular.setErrorInterceptor (response) ->
    console.log 'error'
    loadingStatus false
    switch response.status
      when 401
        auth false
        window.location = 'users/sign_in'
        return false

      when 404
        auth true
        $location.path '/'
        $rootScope.$broadcast 'error', response
        return false
      else
        auth true
        $rootScope.$broadcast 'error', response

  Restangular.addFullRequestInterceptor ->
    loadingStatus true

  Restangular.addResponseInterceptor (data) ->
    console.log 'done.'
    auth true
    loadingStatus false
    data

  $scope.authenticated = false;
  $scope.loc = $location;

  $scope.datepickerOptions = {
    dateFormat: 'dd/mm/yy',
    showOn: 'both'
    buttonText: ''
  }

  $scope.editing = {
    itemNewName: null
    editedItem: null
  }

  $scope.removeItem = (item, collection) ->
    collection.destroy(item)

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
    item.updateAttr(attr).then ->
      $scope.cancelItemEdit()

  # $scope.logout = ->
  #   Restangular.all('users').customDELETE 'sign_out'
  #   window.location = 'users/sign_in'
