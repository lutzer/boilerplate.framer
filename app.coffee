mqtt = require("npm").mqtt
Rx = require("npm").Rx
_ = require("npm").underscore

footer.y = board1.height
footer.states.show =
	y: board1.height - footer.height
	animationOptions:
		time: 0.3
		curve: Bezier.easeInOut
		
button1.states.enable = 
	opacity: 1.0
	animationOptions:
		time: 0.4
		curve: Bezier.linear

mqttClient = mqtt.connect 'mqtt://test.mosquitto.org', { port: 8080}

mqttConnect$ = Rx.Observable.fromEvent(mqttClient, "connect")
mqttConnect$.subscribe (event) ->
	console.log "connected"
	mqttClient.subscribe 'sometopic'
	button1.animate("enable")

# create observable from mqtt message event and apply selector
mqttMessage$ = Rx.Observable.fromEvent mqttClient, "message", (topic, message) -> { topic: topic, message: message.toString() }
mqttMessage$.subscribe (data) ->
	console.log "received"
	console.log data.message
	footer.animate("show")
	Utils.delay 2.0, ->
		footer.animate("default")
			
# only allow the button to be clicked once mqtt is connected
button1Click$ = Rx.Observable.fromEvent(button1,"click")
mqttConnect$.flatMap( (event) -> return button1Click$ ).subscribe (event) ->
	mqttClient.publish "sometopic", "Hello MQTT"
	console.log("publish")
	button1.rotation = 0
	button1.animate
		rotation: 360
		animationOptions:
			time : 0.3
			