extends Camera2D

func _ready():
	
	set_process(true)


func _process(delta):
	var players = get_tree().get_nodes_in_group("Player1")
	set_global_pos( players[0].get_global_pos() )

