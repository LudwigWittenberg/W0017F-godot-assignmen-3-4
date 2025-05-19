extends Area2D

@onready var audio = $AudioStreamPlayer


func _on_body_entered(body: Node2D) -> void:
	var parent = get_parent()
	remove_child(audio)
	parent.add_child(audio)
	
	audio.play()
	queue_free()
