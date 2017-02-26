extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	connect("body_enter", self, "onBodyEnter")
	get_node("Timer").connect("timeout", self, "reset")

func onBodyEnter(obj):
	if (obj.is_in_group("Player1")):
		obj.set_fixed_process(false)
		get_node("Timer").start()
		get_node("Particles2D").set_emitting(true)

func reset():
	get_tree().reload_current_scene()