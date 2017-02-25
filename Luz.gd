extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ready = false

var lb = "LightBlock"
var db = "DarknessBlock"

func _ready():
	if (!ready):
		get_node("Area2D").connect("body_enter", self, "onBodyEnter")
		get_node("Area2D").connect("body_exit", self, "onBodyExit")
		ready = true
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func _fixed_process(delta):
	set_global_pos(get_global_mouse_pos())

func onBodyEnter(obj):
	if (lb.is_subsequence_of(obj.get_name())):
		obj.get_node("CollisionShape2D").set_trigger(false)

func onBodyExit(obj):
	if (lb.is_subsequence_of(obj.get_name())):
		obj.get_node("CollisionShape2D").set_trigger(true)