@app.directive 'throbber', ($rootScope)->
  (scope,elem,attrs) ->
    t = Throbber({
      size: 25               # diameter of loader
      rotationspeed: 3       # rotation speed (1-10)
#      clockwise             # direction, set to false for counter clockwise
#      color                 # color of the spinner, can be any CSS compatible value
      fade: 100              # duration of fadein/out when calling .start() and .stop()
#      fallback              # a gif fallback for non-supported browsers (IE < 8)
      alpha: 1               # global alpha (0-1), can also be defined using rgba color
#      fps                   # frames per second
#      padding               # diameter of clipped inner area
      strokewidth: 2         # width of the lines
      lines: 10
    }).appendTo(elem.context)
    scope.$on 'load', (e, a)->
      console.log e
      if a.active is true then t.start() else t.stop()