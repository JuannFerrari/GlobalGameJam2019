extends KinematicBody2D

var zumbie = self
var speed = 2
onready var target = get_parent().get_node("PlayerOne")

func _ready():
	pass

func _fixed_process(delta):
	var direction = (target.get_global_pos() - zumbie.get_global_pos()).normalized()
	print(direction)
	move(direction*speed) 