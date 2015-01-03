# TODO: check for naming conventions
# for compatibility with Rails CSRF protection

@app = angular.module('exampleApp', [
  'restangular'
  'templates'
]).config([
    '$httpProvider', ($httpProvider)->
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]).run(->
  console.log 'angular app running'
)