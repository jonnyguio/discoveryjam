extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	connect("body_enter", self, "finishLevel")

func finishLevel(obj):
	if (obj.is_in_group("Player1")):
		get_tree().get_root().get_node("Scenario").queue_free()
		
