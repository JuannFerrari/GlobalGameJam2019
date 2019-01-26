extends KinematicBody2D

var motion=Vector2()
var direction=0
export var life = 5
var dead = false
var can_take_damage = true
export var action_up="ui_up"
export var action_down="ui_down"
export var action_right="ui_right"
export var action_left="ui_left"
export var action_shoot="ui_accept"
export var ACCELERATION=50
export var MAX_SPEED=300
export var shot_spread=0.1
export var shot_count=5
var bullet_scene = preload ("res://ShotgunBullet.tscn")
signal health_changed(health)


func shoot_bullet():
	for i in range (shot_count):
	  var bullet= bullet_scene.instance()
	  get_parent().add_child(bullet)
	  bullet.direction=direction-(i-2)*shot_spread
	  bullet.set_rotation(bullet.direction)
	  bullet.set_global_position(get_global_position())


func _physics_process(delta):

	if !dead:
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

		if(motion < Vector2(1, 1) and motion > Vector2(-1, -1) ):
			if $AnimationPlayer.current_animation != "idle":
				$AnimationPlayer.play("idle")
		else:
			if ($AnimationPlayer.current_animation != "Move"):
				$AnimationPlayer.play("Move")

		move_and_collide(motion * delta)


	else:
		$AnimationPlayer.play("idle")
		$CollisionShape2D.disabled = true


func _on_invul_timer_timeout():
	can_take_damage=true
	if !dead:
		modulate = Color(1,1,1,1)
	$CollisionShape2D.disabled = false



func take_damage():
	if can_take_damage:
		life-=1
		emit_signal("health_changed",life)
		can_take_damage = false
		$invul_timer.start(1.5)
		modulate = Color(1,1,1,0.3)
		$CollisionShape2D.disabled = true

	if life<=0:
		dead = true
		#is now ded blep
		set_rotation_degrees(85)

func _on_Hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	pass