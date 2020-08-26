extends Area2D

func _on_heart_body_entered(body: Node) -> void:
	if body is Player and !MANAGER.player_is_full():
		MANAGER.change_life(1)
		queue_free()
