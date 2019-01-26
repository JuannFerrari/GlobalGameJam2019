extends KinematicBody2D

var speed = 100
var direction = 0
var life=1
onready var playerOne = get_parent().get_node("Player1")
onready var playerTwo = get_parent().get_node("Player2")
onready var targets = [playerOne, playerTwo]
var target
var index
signal self_killed

func _ready():
	index = randi()%2+0
	target = targets[index]
	self.connect("self_killed", get_parent().get_node('Interface'), "_on_EnemyOne_self_killed")
	pass

func _physics_process(delta):
	if target.dead:
		if index == 0:
			target = targets[1]
		else:
			target = targets[0]
	direction = (target.position - position).normalized()
	move_and_collide(direction * speed * delta) 
	if life <=0:
		emit_signal("self_killed")
		queue_free()
	#	if collision_info:   #only collides after move
	#		collision_info.collider.queue_free()
