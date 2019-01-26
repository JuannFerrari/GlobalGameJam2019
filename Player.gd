extends KinematicBody2D

var motion=Vector2()
var direction=0
export var life = 5
export var action_up="ui_up" 
export var action_down="ui_down"
export var action_right="ui_right"
export var action_left="ui_left"
export var action_shoot="ui_accept"
export var ACCELERATION=50
export var MAX_SPEED=300

var bullet_scene = preload ("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot_bullet():
	var bullet= bullet_scene.instance()
	get_parent().add_child(bullet)
	bullet.set_rotation(direction)
	bullet.direction=direction
	bullet.set_global_position(get_global_position())

func _physics_process(delta):
	if Input.is_action_just_pressed(action_shoot):
		shoot_bullet()
	
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
	
	direction=motion.angle()
<<<<<<< Updated upstream:Player.gd
	move_and_collide(motion * delta)
	if life <=0:
		queue_free()
		
		
func _on_EnemyOne_body_entered(body):
	body.life-=1
	queue_free()
=======
	
	if(motion < Vector2(1, 1) and motion > Vector2(-1, -1) ):
		print("standing still")
		if $AnimationPlayer.current_animation != "idle":
			$AnimationPlayer.play("idle")
	else:
		if ($AnimationPlayer.current_animation != "Move"):
			$AnimationPlayer.play("Move")
		
	
	move_and_slide(motion)
>>>>>>> Stashed changes:KinematicBody2D.gd
