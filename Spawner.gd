extends Position2D

export (PackedScene) var spawnScene
onready var spawnReference = load (spawnScene.get_path())

export (NodePath) var timerPath
onready var timerNode = get_node(timerPath)

export (float) var minWaitTime
export (float) var maxWaitTime
onready var playerOne = get_parent().get_node("Player1")
onready var playerTwo = get_parent().get_node("Player2")
signal game_over

func _ready():
	randomize()
	timerNode.set_wait_time(rand_range(minWaitTime, maxWaitTime))
	timerNode.start()

func _on_Timer_timeout():
	if (!playerOne.dead || !playerTwo.dead):
		var spawnInstance = spawnReference.instance()
	
		get_parent().add_child(spawnInstance)
		spawnInstance.position = position
	
		timerNode.set_wait_time(rand_range(minWaitTime, maxWaitTime))
		timerNode.start()
	else:
		emit_signal('game_over')
		
