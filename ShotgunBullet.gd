extends Area2D

const VEL=1000

export var direction=0



# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true) # Replace with function body.

func _process(delta):
	var angle_vector= Vector2(cos(direction), sin(direction))
	var motion=angle_vector*VEL
	position=position+motion*delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	



func _on_ShotgunBullet_area_entered(area):
	print (area.name)
	area.life-=1
	queue_free()# Replace with function body.
