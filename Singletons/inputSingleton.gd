extends Node

var keys = {}

var frame = 0;

func _ready():
	for act in InputMap.get_actions():
		if( true or ( keys.has( act ) == false and var2str(act).substr(1,2) != "ui" ) ):
			var inst = { up = false , on = false , down = false }
			keys[act] = inst
	set_process(true)
	set_process_input(true)
	pass

func _process(delta):
	call_deferred("clearActions")
	pass

func _input(event):
	for act in keys.keys():
		if( event.is_action_pressed(act) ):
			keys[act].down = true
			keys[act].on = true
		elif( event.is_action_released(act) ):
			keys[act].up = true
			keys[act].on = false
	pass

func clearActions():
	for act in keys.keys():
		keys[act].down = false
		keys[act].up = false

func isKeyBeingPressed( var key_name ):
	return keys[key_name].on
	pass

func wasKeyPressedNow( var key_name ):
	return keys[key_name].down
	pass

func wasKeyPressedUp( var key_name ):
	return keys[key_name].up
	pass