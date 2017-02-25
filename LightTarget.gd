extends Position2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)

func _process(delta):
	set_global_pos( get_global_mouse_pos() )
