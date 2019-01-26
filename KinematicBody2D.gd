extends KinematicBody2D

var motion=Vector2()
export var action_up="" 
export var action_down=""
export var action_right=""
export var action_left=""
export var ACCELERATION=50
export var MAX_SPEED=300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed(action_right):
		motion.x= min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed(action_left):
		motion.x= max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		motion.x=lerp(motion.x,0,0.2)
	if Input.is_action_pressed(action_up):
		motion.y=max(motion.y - ACCELERATION, -MAX_SPEED)
	elif Input.is_action_pressed(action_down):
		motion.y=min(motion.y + ACCELERATION, MAX_SPEED)
	else:
		motion.y=lerp(motion.y,0,0.2)
	move_and_slide(motion)