@app = angular.module('app', [
  'restangular'
  'templates'
])

# TODO: check for naming conventions
# TODO: check what does AT-sign mean

# for compatibility with Rails CSRF protection

@app.config([
  '$httpProvider', ($httpProvider)->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

@app.run(->
  console.log 'angular app running'
)