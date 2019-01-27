extends Control

onready var number_label_p1 = get_node("LifeCounterP1").get_node("Number")
onready var number_label_p2 = get_node("LifeCounterP2").get_node("Number")
onready var score_label = get_node("KillsCounter").get_node("Number")
onready var game_over_label = get_node("GameOver")
onready var death_player = get_node("DeathPlayer")
onready var death_timer = death_player.get_node("DeathTimer")
onready var spawn_player = get_node("SpawnPlayer")
onready var spawn_timer = spawn_player.get_node("SpawnTimer")


var sound_spawn = preload("res://sounds/sound_ghost.ogg")
var sound_death = preload("res://sounds/sound_ghost_death.ogg")

var game_over = false

func _ready():
	death_player.stream = sound_death
	spawn_player.stream = sound_spawn

func _on_Player1_health_changed(health):
	update_health_p1(health)

func update_health_p1(new_value):
    number_label_p1.text = str(new_value)

func _on_Player2_health_changed(health):
	update_health_p2(health)

func update_health_p2(new_value):
    number_label_p2.text = str(new_value)

func _on_EnemyOne_self_killed():
	death_player.play()
	score_label.text = str(int(score_label.text) + 1)
	death_timer.start(0.8)

func _on_Spawner_game_over():
	game_over_label.show()
	game_over = true

func _input(event):
	if event is InputEventKey && game_over == true:
		if event.pressed:
			get_tree().reload_current_scene()

func _on_EnemyOne_spawned():
	if !spawn_player.playing:
		spawn_player.play()
		spawn_timer.start(5)
	

func _on_SpawnTimer_timeout():
	spawn_player.stop()


func _on_DeathTimer_timeout():
	death_player.stop()
