@app.directive 'formErrors', ->
  {
    restrict: 'E'
    transclude: true
    template:
      '
        <div class="icon"></div>
        <ul>
          <li ng-repeat="(k, v) in errors">
            {{v[0].$name}} {{getMessage(k)}}
          </li>
        </ul>
      '
    link: (scope, elem, attrs) ->
      scope.$watch ->
        valid = scope[attrs.name].$valid
        if valid then elem.hide() else elem.show()

      scope.errors = scope[attrs.name].$error

      scope.getMessage = (k) ->
        message = ' is invalid'
        if k is 'required'
          message = 'can\'t be blank'
        else if k is 'minlength'
          message = 'is too short'
        message
  };