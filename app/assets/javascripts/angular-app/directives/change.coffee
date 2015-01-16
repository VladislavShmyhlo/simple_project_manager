@app.directive 'change', ->
  (scope, element, attrs) ->
    element.bind 'change', ->
      scope.$apply attrs['change']