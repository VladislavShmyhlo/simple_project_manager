@app.controller "ApplicationController", ($scope, Restangular, $location) ->
  Restangular.setErrorInterceptor (response, deferred, responseHandler) ->
    if response.status is 401
      $location.path('/login')
      return false
    else
      console.log "error #{response.status}"