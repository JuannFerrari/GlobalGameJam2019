extends KinematicBody2D

var speed = 100
var direction = 0
onready var target = get_parent().get_node("Player")

func _ready():
	pass

func _physics_process(delta):
	direction = (target.position - position).normalized()
	move_and_slide(direction*speed) 