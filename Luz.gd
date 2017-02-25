extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ready = false

func _ready():
	if (!ready):
		get_node("Area2D").connect("body_enter", self, "onBodyEnter")
		get_node("Area2D").connect("body_exit", self, "onBodyExit")
		ready = true
	
	set_fixed_process(true)

func _fixed_process(delta):
	var destiny = get_tree().get_nodes_in_group("LightTarget")
	if( destiny.size() > 0 ):
		destiny = destiny[0].get_global_pos()
		set_global_pos( 0.95*get_global_pos() + 0.05*destiny )
		if( destiny.x > get_global_pos().x ):
			get_node("Sprite").set_flip_h(false)
		else:
			get_node("Sprite").set_flip_h(true)

func onBodyEnter(obj):
	if( obj.is_in_group("LightBlock") ):
		obj.get_node("CollisionShape2D").set_trigger(false)
		obj.set_hidden(false)

func onBodyExit(obj):
	if( obj.is_in_group("LightBlock") ):
		obj.get_node("CollisionShape2D").set_trigger( true )
		obj.set_hidden( true )