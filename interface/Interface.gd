extends Control

onready var number_label_p1 = get_node("LifeCounterP1").get_node("Number")
onready var number_label_p2 = get_node("LifeCounterP2").get_node("Number")
onready var score_label = get_node("KillsCounter").get_node("Number")
onready var game_over_label = get_node("GameOver")
var game_over = false

func _on_Player1_health_changed(health):
	update_health_p1(health)

func update_health_p1(new_value):
    number_label_p1.text = str(new_value)

func _on_Player2_health_changed(health):
	update_health_p2(health)

func update_health_p2(new_value):
    number_label_p2.text = str(new_value)

func _on_EnemyOne_self_killed():
	score_label.text = str(int(score_label.text) + 1)

func _on_Spawner_game_over():
	game_over_label.show()
	game_over = true

func _input(event):
	if event is InputEventKey && game_over == true:
		if event.pressed:
			get_tree().reload_current_scene()
