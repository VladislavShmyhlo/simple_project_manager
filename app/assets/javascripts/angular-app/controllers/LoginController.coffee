@app.controller "LoginController", ($scope, Restangular) ->
  u = Restangular.all 'users/sign_in'
  $scope.login = (user) ->
    user.remember_me = 1
    console.log user
    u.post(user)
