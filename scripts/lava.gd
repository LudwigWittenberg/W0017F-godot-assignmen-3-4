extends AnimatedSprite2D

signal dead


func _on_area_2d_body_entered(body: Node2D) -> void:
	emit_signal("dead")
