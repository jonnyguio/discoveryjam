extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var velocity = Vector2(0, 0)
var speedBase = 150
var gravity = 11
var jumps = 1
var on_floor = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	velocity.y += gravity
	
	var motion = velocity * delta
	motion = move(motion)
	
	on_floor = false
	if (is_colliding()):
		var n = get_collision_normal()
		if( n.y == -1 ):
			on_floor = true
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
		
	if (velocity.y == 0):
		jumps = 1
		
	updateControl()
	updateAnimation()
	
	if (velocity.x != 0):
		get_node("AnimationPlayer").set_active(true)
	else:
		get_node("AnimationPlayer").set_active(false)
	
	var collider = get_node("Sprite").get_node("RayCast2D").get_collider()
	if (collider and is_colliding() and collider.get_type() == "KinematicBody2D"):
		if (collider.get_name() == "PushableBlock"):
			collider.moveBlock(velocity, delta)

func updateAnimation():
	if( on_floor ):
		if( velocity.x != 0 ):
			if( get_node("AnimationPlayer").get_current_animation() != "Walk"):
				get_node("AnimationPlayer").set_current_animation("Walk")
			
	pass

func updateControl():
	if (InputSingleton.isKeyBeingPressed("ui_left")):
		velocity.x = -1 * speedBase
		set_scale(Vector2(-1, 1))
	if (InputSingleton.isKeyBeingPressed("ui_right")):
		velocity.x = 1 * speedBase
		set_scale(Vector2(1, 1))
	if (!InputSingleton.isKeyBeingPressed("ui_left") and !InputSingleton.isKeyBeingPressed("ui_right")):
		velocity.x = 0
	if (InputSingleton.isKeyBeingPressed("ui_up")):
		if (jumps > 0):
			velocity.y = -3 * speedBase
			jumps -= 1
