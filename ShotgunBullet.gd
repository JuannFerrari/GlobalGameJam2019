extends Area2D

const VEL=1000
const damage=1.5


export var direction=0



# Called when the node enters the scene tree for the first time.
func _ready():
	$DespawnTimer.start(0.3)
	set_process(true) # Replace with function body.

func _process(delta):
	var angle_vector= Vector2(cos(direction), sin(direction))
	var motion=angle_vector*VEL
	position=position+motion*delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	



func _on_ShotgunBullet_area_entered(area):
	if area.life>0:
	  area.life-=damage
	queue_free()# Replace with function body.


func _on_DespawnTimer_timeout():
	queue_free() # Replace with function body.
