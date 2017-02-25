extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("body_enter", self, "finishLevel", [], CONNECT_DEFERRED)

func finishLevel(obj):
	var nextLevelPath = get_parent().nextLevelPath
	if (obj.is_in_group("Player1")):
		var nextLevelResource = load(nextLevelPath)
		var inst = nextLevelResource.instance()
		get_tree().get_root().add_child(inst)
		get_tree().get_nodes_in_group("Camera")[0].free()
		get_tree().get_root().get_node("Scenario").call_deferred("queue_free")
