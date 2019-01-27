extends Area2D

var speed = 100
var direction = 0
var life=20
var notified_death = false
onready var playerOne = get_parent().get_node("Player1")
onready var playerTwo = get_parent().get_node("Player2")
onready var targets = [playerOne, playerTwo]
var target
var index
signal self_killed
signal spawned

func _ready():
	index = randi()%2+0
	target = targets[index]
	self.connect("self_killed", get_parent().get_node('Interface'), "_on_EnemyOne_self_killed")
	self.connect("spawned", get_parent().get_node('Interface'), "_on_EnemyOne_spawned")
	emit_signal("spawned")


func _physics_process(delta):
	if life >0:
		if targets[0].dead and targets[1].dead:
			queue_free()
	
	
		if target.dead or not target.can_take_damage:
			if index == 0 and (!targets[1].dead):
				target = targets[1]
			elif index == 1 and (!targets[0].dead):
				target = targets[0]
			else:
				#both are dead
				pass
		direction = (target.position - position).normalized()
	
		if (target.position - position).x > 0:
			$icon.flip_h = true
		else:
			$icon.flip_h = false
	
		position = position + (direction * speed * delta)
	else:
		if !notified_death:
			die()


func die():
	life = 0
	$AnimationPlayer.play("ded")
	notified_death = true
	emit_signal("self_killed")

func take_damage(damage):
	life -=damage
	$AnimationPlayer.play("hit")
	$Hitsound.play()

func _on_EnemyOne_body_entered(body):
	if (life>0):
		body.take_damage()
		die()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ded":
		queue_free()
