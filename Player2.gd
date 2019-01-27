extends KinematicBody2D

var motion=Vector2()
var direction=0
export var life = 5
var dead = false
var can_take_damage = true
var notified_death = false
export var action_up="ui_up"
export var action_down="ui_down"
export var action_right="ui_right"
export var action_left="ui_left"
export var action_shoot="ui_accept"
export var ACCELERATION=50
export var MAX_SPEED=300
export var shot_spread=0.1
export var shot_count=5
const FIRE_RATE=0.5
var can_shoot=true
var bullet_scene = preload ("res://ShotgunBullet.tscn")
signal health_changed(health)


func shoot_bullet():
	if can_shoot:
		Input.start_joy_vibration(0, 0.3, 0, 0.3)
		can_shoot=false
		$fire_rate.start(FIRE_RATE)
		for i in range (shot_count):
		  var bullet= bullet_scene.instance()
		  get_parent().add_child(bullet)
		  bullet.direction=direction-(i-2)*shot_spread
		  bullet.set_rotation(bullet.direction)
		  bullet.set_global_position(get_global_position())


func _physics_process(delta):

	if life>0:
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

		if (motion.x<5 and motion.x >-5) and (motion.y<5 and motion.y >-5):
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("walk")
		
		if motion.x >0:
			$AnimatedSprite.flip_h=true
		else:
			$AnimatedSprite.flip_h=false
		
		if Input.is_action_pressed(action_shoot):
			$AnimatedSprite.play("attack")
			shoot_bullet()
			
		move_and_collide(motion * delta)
	else:
		die()
		


func _on_invul_timer_timeout():
	if !dead:
		can_take_damage=true
		modulate = Color(1,1,1,1)
		$CollisionShape2D.disabled = false

func die():
	$CollisionShape2D.disabled = true
	if !notified_death:
		notified_death = true
		dead = true
		modulate= Color(1,1,1,1)
		$AnimatedSprite.flip_h=false
		$DeathSound.play()
		$AnimatedSprite.play("dead")
		$CollisionShape2D.disabled = true
		can_take_damage=false

func take_damage():
	if can_take_damage:
		life-=1
		emit_signal("health_changed",life)
		Input.start_joy_vibration(0, 0, 0.3, 0.3)
		can_take_damage = false
		$invul_timer.start(1.5)
		modulate = Color(1,1,1,0.3)
		$CollisionShape2D.disabled = true

	if life<=0:
		die()
		#is now ded blep

func _on_Hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	pass

func _on_fire_rate_timeout():
	can_shoot=true
