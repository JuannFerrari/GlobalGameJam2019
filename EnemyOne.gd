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
signal spawned

func _ready():
	index = randi()%2+0
	target = targets[index]
	self.connect("self_killed", get_parent().get_node('Interface'), "_on_EnemyOne_self_killed")
	self.connect("spawned", get_parent().get_node('Interface'), "_on_EnemyOne_spawned")
	emit_signal("spawned")

func _physics_process(delta):


	if targets[0].dead and targets[1].dead:
		queue_free()


	if target.dead or ! target.can_take_damage:
		if index == 0:
			target = targets[1]
		else:
			target = targets[0]
	direction = (target.position - position).normalized()

	if (target.position - position).x > 0:
		$icon.flip_h = true
	else:
		$icon.flip_h = false

	position = position + (direction * speed * delta)

	var over_lapping_bodies= get_overlapping_bodies()
	if over_lapping_bodies.size() >0:
		over_lapping_bodies[0].take_damage()
		emit_signal("self_killed")
		queue_free()

	if life <=0:
		emit_signal("self_killed")
		queue_free()


func take_damage(damage):
	life -=damage
	$AnimationPlayer.play("hit")
