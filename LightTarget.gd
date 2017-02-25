extends Position2D


var velocity = Vector2(0,0)

func _ready():
	set_process(true)
	set_process_input(true)
	

func _process(delta):
	updateControl()
	set_global_pos( get_global_pos() + velocity*delta*60 )



func updateControl():
	var dir = Vector2(0,0)
	
	if( abs(Input.get_joy_axis(0,0)) > 0.9  ):
		dir.x = Input.get_joy_axis(0,0)
	
	if( abs(Input.get_joy_axis(0,1)) > 0.9  ):
		dir.y = Input.get_joy_axis(0,1)
	
	
	if( dir == Vector2(0,0) ):
		velocity = Vector2(0,0)
	else:
		velocity = dir.normalized()*9