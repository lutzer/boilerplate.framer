{Rx, _} = require("npm")
{ CarousselComponent } = require("CarousselComponent")

# button = new Layer
#   backgroundColor: "#FF00FF"
#
# buttonClick$ = Rx.Observable.fromEvent(button, "click")
# buttonClick$.subscribe (event) ->
#   console.log("click")
#
# scrollArea = new Layer
# scrollArea.center()

items = []
for i in [0..10]
  items.push( new Layer
    backgroundColor : "hsl("+i*20+",95,57)"
  )

caroussel = new CarousselComponent items, 5,
  width: 500
  height: 200
  backgroundColor : "blue"
