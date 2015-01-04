# TODO: check for naming conventions
# for compatibility with Rails CSRF protection

@app = angular.module('exampleApp', [
  'restangular'
  'templates'
]).config((RestangularProvider) ->
    RestangularProvider.setDefaultHeaders {
      'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')
      'Accept': 'application/json'
    }
).run(->
  console.log 'angular app running'
)