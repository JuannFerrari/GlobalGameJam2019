extends Area2D


const VEL=300
export var direction = 0

	
	
func _process(delta):
	var angle_vector= Vector2(cos(direction), sin(direction))
	var motion=angle_vector*VEL
	position=position+motion*delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_area_entered(area):
	print("hola")
	queue_free()
	area.queue_free()
