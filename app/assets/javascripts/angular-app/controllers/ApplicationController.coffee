@app.controller "ApplicationController", ($rootScope, $scope, Restangular, $location) ->
  Restangular.setErrorInterceptor (response, deferred, responseHandler) ->
    if response.status is 401
      $location.path('/login')
      return false
    else
      console.log "error #{response.status}"

  Restangular.addFullRequestInterceptor ->
    $rootScope.$broadcast 'load', {active: true}
    return
  Restangular.addResponseInterceptor (data) ->
    console.log 'done.'
    $rootScope.$broadcast 'load', {active: false}
    data