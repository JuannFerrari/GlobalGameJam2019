extends Area2D

var speed = 100
var direction = 0
var life=1
onready var playerOne = get_parent().get_node("Player1")
onready var playerTwo = get_parent().get_node("Player2")
onready var targets = [playerOne, playerTwo]
var target
var index

func _ready():
	index = randi()%2+0
	target = targets[index]

func _physics_process(delta):
	
	if targets[0].dead and targets[1].dead:
		queue_free()
	
	
	if target.dead:
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
	
	if life <=0:
		queue_free()




func _on_EnemyOne_body_entered(body):
	print(body.name)
	if body.name == "Player1" or body.name == "Player2":
		if body.can_take_damage:
			body.take_damage()
			queue_free()
