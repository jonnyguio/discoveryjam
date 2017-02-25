extends Camera2D

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	var players = get_tree().get_nodes_in_group("Player1")
	if (players.size() > 0):
		set_global_pos( players[0].get_global_pos() )

