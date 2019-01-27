extends Area2D

const VEL=1000
const damage=3


export var direction=0
signal fired


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("fired", get_parent().get_node('Interface'), "_on_Shotgun_fired")
	emit_signal("fired")
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
	  area.take_damage(damage)
	queue_free()# Replace with function body.


func _on_DespawnTimer_timeout():
	queue_free() # Replace with function body.
