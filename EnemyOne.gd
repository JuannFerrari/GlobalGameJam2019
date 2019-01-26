extends KinematicBody2D

var speed = 100
var direction = 0
onready var target = get_parent().get_node("Player")
var wr = weakref(self);

func _ready():
	pass

func _physics_process(delta):
	direction = (target.position - position).normalized()
	var collision_info = move_and_collide(direction*speed * delta) 
	
	#	if collision_info:   #only collides after move
	#		collision_info.collider.queue_free()