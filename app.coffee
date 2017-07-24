mqtt = require("npm").mqtt
Rx = require("npm").Rx

mqttClient = mqtt.connect 'mqtt://test.mosquitto.org', { port: 8080}

mqttConnect$ = Rx.Observable.fromEvent(mqttClient, "connect")
mqttConnect$.subscribe (event) ->
	console.log "connected"
	mqttClient.subscribe 'presence'
	button1.animate("enable")

mqttClient.on 'message', (topic, message) ->
	console.log "received"
	console.log message.toString()
	circle.animate
		opacity : 1

button1.states.enable = 
	opacity: 1.0
	animationOptions:
		time: 0.4
		curve: Bezier.linear
			
# only allow the button to be clicked once when mqtt is connected
button1Click$ = Rx.Observable.fromEvent(button1,"click")
button1Click$.skipUntil(mqttConnect$).first().subscribe (event) ->
	mqttClient.publish "presence", "Hello MQTT"
	button1.animate
		rotation: 360
		animationOptions:
			time : 0.3

# example for a simple counter
circleBottomClick$ = Rx.Observable.fromEvent(circleBottom,"click")
circleBottomClick$.startWith(0).scan( (count) -> (count = count + 1) % 10)
	.subscribe (val) ->
		circleText.html =
			'<span style="text-align:center; font-size:14pt;">'+val+'</span>'
		circleText.x = Align.center(-2)
		circleText.y = Align.center(-8)
			