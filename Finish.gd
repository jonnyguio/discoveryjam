extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (String) var nextLevelPath

func _ready():
	connect("body_enter", self, "finishLevel")

func finishLevel(obj):
	if (obj.is_in_group("Player1")):
		var nextLevelResource = load(nextLevelPath)
		var inst = nextLevelResource.instance()
		get_tree().get_root().add_child(inst)
		get_tree().get_root().get_node("Scenario").call_deferred("queue_free")
		
		
