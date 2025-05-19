extends Area2D

signal wentThroughDoor

var isLocked = true
var playerOnDoor = false
@onready var audio = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	playerOnDoor = true
		

func _on_body_exited(body: Node2D) -> void:
	playerOnDoor = false

func _physics_process(delta: float) -> void:
	if not isLocked and playerOnDoor and Input.is_action_just_pressed("forward"):
		emit_signal("wentThroughDoor")
	

func set_door_lock_state(value: bool):
	isLocked = value
	
	if not isLocked:
		$AnimatedSprite2D.animation = "open"
		audio.play()
