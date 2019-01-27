extends Area2D


const VEL=500
export var direction = 0
const damage=8
signal fired

func _ready():
	self.connect("fired", get_parent().get_node('Interface'), "_on_Bullet_fired")
	emit_signal("fired")
	
func _process(delta):
	var angle_vector= Vector2(cos(direction), sin(direction))
	var motion=angle_vector*VEL
	position=position+motion*delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	if area.life>0:
	  area.take_damage(damage)
	queue_free()
