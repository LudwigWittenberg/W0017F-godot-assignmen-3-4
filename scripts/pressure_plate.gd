extends Area2D


signal pressed

var state = true


func _on_body_entered(body: Node2D) -> void:
	if state:
		emit_signal("pressed", false)
		state = false # only press once
 
