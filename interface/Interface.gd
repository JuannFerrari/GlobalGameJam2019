extends Control

onready var number_label = get_node("LifeCounter").get_node("Number")
onready var score_label = get_node("KillsCounter").get_node("Number")

func _on_Player1_health_changed(health):
	update_health(health)

func update_health(new_value):
    number_label.text = str(new_value)

func _on_EnemyOne_self_killed():
	score_label.text = str(int(score_label.text) + 1)



