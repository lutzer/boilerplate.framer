{Rx, _} = require("npm")

button = new Layer
  backgroundColor: "#FF00FF"

buttonClick$ = Rx.Observable.fromEvent(button, "click")
buttonClick$.subscribe (event) ->
  console.log("click")
