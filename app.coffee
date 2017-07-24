mqtt = require("npm").mqtt
Rx = require("npm").Rx

Rx.Observable.of(1,2,3)

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
		time: 1
		curve: Bezier.linear
			
# only allow the button to be clicked when the other one was clicked already
button1Click$ = Rx.Observable.fromEvent(button1,"click")
button1Click$.skipUntil(mqttConnect$).first().subscribe (event) ->
	mqttClient.publish "presence", "Hello MQTT"
	button1.animate
		rotation: 360
		animationOptions:
			time : 0.5
			
 
	
		


