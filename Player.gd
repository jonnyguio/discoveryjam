extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var velocity = Vector2(0, 0)
var speedBase = 150
var gravity = 11
var jumps = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	get_node("Sprites/Body").set_use_parent_material(false)
	get_node("Sprites/Foots").set_use_parent_material(false)
	
func _fixed_process(delta):
	
	var motion = velocity * delta
	motion = move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		if( n.y <= -0.9 ):
			velocity.y = 0
		motion = n.slide(motion)
		move( motion )
	
	if (velocity.y == 0):
		jumps = 1
	
	velocity.y += gravity
	
	updateControl()
	updateAnimation()
	
	var collider = get_node("Sprites").get_node("RayCast2D").get_collider()
	if (collider and is_colliding() and collider.get_type() == "KinematicBody2D"):
		if (collider.get_name() == "PushableBlock"):
			print("Nada")
			#collider.moveBlock(velocity, delta)

func updateAnimation():
	if( isOnFloor() and velocity.x != 0 ):
		if( get_node("Sprites/Foots/FootsAnimator").get_current_animation() != "walking"):
			get_node("Sprites/Foots/FootsAnimator").play("walking")
	else:
		if( get_node("Sprites/Foots/FootsAnimator").get_current_animation() != "standing"):
			get_node("Sprites/Foots/FootsAnimator").play("standing")

func updateControl():
	velocity.x = 0
	if (abs(Input.get_joy_axis(1, 0)) > 0.5):
		if (InputSingleton.isKeyBeingPressed("1_left")):
			velocity.x = -1 * speedBase
			set_scale(Vector2(-1, 1))
		if (InputSingleton.isKeyBeingPressed("1_right")):
			velocity.x = 1 * speedBase
			set_scale(Vector2(1, 1))
	if (abs(Input.get_joy_axis(1, 1)) > 0.5):
		if (InputSingleton.isKeyBeingPressed("1_up")):
			if (jumps > 0):
				velocity.y = -3 * speedBase
				jumps -= 1

func isOnFloor():
	return get_node("floorChecker").is_colliding()