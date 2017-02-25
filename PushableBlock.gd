extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var gravity = 11
var speedBase = 150
var velocity = Vector2(0, 0)

func _ready():
	#depois mexo nisso...
	set_fixed_process(false)


func _fixed_process(delta):
	velocity.y += gravity
	var motion = velocity * delta
	
	move(motion)
	
func moveBlock(push_velocity, delta):
	var motion = push_velocity * delta
	
	move(motion)
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		push_velocity = n.slide(push_velocity)
		move(motion)
	
	