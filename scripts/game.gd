extends Node2D

@onready var lavas = $Lavas
@onready var player = $Player
@onready var respawnPoint = $TileMaps/RespawnPoints
@onready var pressurePlate = $TileMaps/PressurePlate
@onready var door = $TileMaps/Door
@onready var killZone = $TileMaps/KillZone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_deaths()
	connect_to_lavaSignal()
	connect_to_respawnPointSignal()
	connect_to_pressurePlate()
	connect_to_door()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("esc")):
		exitGame()


func connect_to_lavaSignal():
	for lava in lavas.get_children():
		if lava and lava.has_signal("dead"):
			lava.dead.connect(death)
		else:
			print("Error: Lava node missing or signal not found!")

		

func connect_deaths():
	if killZone and killZone.has_signal("dead"):
		killZone.dead.connect(death)
	else:
		print("Error: killZone node missing or signal not found!")

func death():
	# respwan player
	player._on_respawn()	


func connect_to_respawnPointSignal():
	if respawnPoint and respawnPoint.has_signal("respawnPoint"):
		respawnPoint.respawnPoint.connect(setNewRespawnPoint)
	else:
		print("Error: respawnPoint node missing or signal not found!")


func setNewRespawnPoint():
	player.set_player_location(1636, -190)


func connect_to_pressurePlate():
	if pressurePlate and pressurePlate.has_signal("pressed"):
		pressurePlate.pressed.connect(setDoorOpend)
	else:
		print("Error: pressurePlate node missing or signal not found!")


func setDoorOpend(value):
	door.set_door_lock_state(value)
	

func exitGame():
	get_tree().quit()


func connect_to_door():
	if door and door.has_signal("wentThroughDoor"):
		door.wentThroughDoor.connect(restartGame)
	else:
		print("Error: wentThroughDoor node missing or signal not found!")


func restartGame():
	get_tree().reload_current_scene()
