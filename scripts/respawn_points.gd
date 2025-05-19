extends Area2D

signal respawnPoint

var alreadySounded = false
@onready var audio = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if not alreadySounded:
		audio.play()
		emit_signal("respawnPoint")
		alreadySounded = true
