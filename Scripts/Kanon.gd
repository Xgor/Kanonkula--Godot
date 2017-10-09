extends KinematicBody2D

export var speed = 0
export var drag = 0

export var i_up = ""
export var i_left= ""
export var i_down = ""
export var i_right = ""

var movVec = Vector2()
var velocity = Vector2()


func Acceleration():
	return speed *drag

func Friction():
	return drag

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	set_fixed_process(true)
	pass

func _input(event):
	
	pass

func _fixed_process(delta):
	if(Input.is_action_pressed(i_up)):
		movVec.y = -1
	elif(Input.is_action_pressed(i_down)):
		movVec.y = 1
	else:
		movVec.y = 0
	
	if(Input.is_action_pressed(i_left)):
		movVec.x = -1
	elif(Input.is_action_pressed(i_right)):
		movVec.x = 1
	else:
		movVec.x = 0
	
	movVec= movVec.normalized()
	
	velocity -= Friction()*delta*velocity
	velocity += Acceleration()*movVec*delta
	
	var motion = velocity*delta
	move(motion)
	
	var aim = get_global_mouse_pos()-get_pos()
	
	set_rot(atan2(-aim.y,aim.x))
	
	if(is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

