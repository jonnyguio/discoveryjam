extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var velocity = Vector2(0, 0)
var speedBase = 150
var gravity = 11

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	velocity.y += gravity
	
	var motion = velocity * delta
	motion = move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
	
func _input(event):
	if (event.is_action_pressed("ui_left")):
		velocity.x += -1 * speedBase
	if (event.is_action_pressed("ui_right")):
		velocity.x += 1 * speedBase
	if (event.is_action_pressed("ui_up")):
		velocity.y = -3 * speedBase
	if (event.is_action_released("ui_left")):
		velocity.x += 1 * speedBase
	if (event.is_action_released("ui_right")):
		velocity.x += -1 * speedBase
		
	
	