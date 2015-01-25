@app.directive 'messages', ->
  {
    restrict: 'E'
    template:
      '
        <strong class="status">{{error.status}}</strong>
        <span class="text">{{error.statusText}}</span>
        <a ng-click="hide()"></a>
      '
    link: (scope, elem, attrs) ->
      scope.hide = ->
        elem.hide()
        return
      elem.hide()
      scope.$on 'error', (e, error) ->
        scope.error = error
        elem.show()
  };