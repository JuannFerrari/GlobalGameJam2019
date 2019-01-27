extends Area2D

var speed = 100
var direction = 0
var life=20
onready var playerOne = get_parent().get_node("Player1")
onready var playerTwo = get_parent().get_node("Player2")
onready var targets = [playerOne, playerTwo]
var target
var index
signal self_killed

func _ready():
	index = randi()%2+0
	target = targets[index]
	if target.dead or ! target.can_take_damage:
		if index == 0 and (!targets[1].dead or targets[1].can_take_damage):
			target = targets[1]
		elif index == 1 and (!targets[0].dead or targets[0].can_take_damage):
			target = targets[0]
		else:
			pass
	self.connect("self_killed", get_parent().get_node('Interface'), "_on_EnemyOne_self_killed")
	pass

func _physics_process(delta):

	if targets[0].dead and targets[1].dead:
		queue_free()


	if target.dead or ! target.can_take_damage:
		if index == 0 and (!targets[1].dead or targets[1].can_take_damage):
			target = targets[1]
		elif index == 1 and (!targets[0].dead or targets[0].can_take_damage):
			target = targets[0]
		else:
			pass
	direction = (target.position - position).normalized()

	if (target.position - position).x > 0:
		$icon.flip_h = true
	else:
		$icon.flip_h = false

	position = position + (direction * speed * delta)
	
	
	if life <=0:
		emit_signal("self_killed")
		queue_free()
	

func take_damage(damage):
	life -=damage
	$AnimationPlayer.play("hit")

func _on_EnemyOne_body_entered(body):
	body.take_damage()
	queue_free()
