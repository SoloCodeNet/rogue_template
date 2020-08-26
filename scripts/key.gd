extends Area2D


func _ready() -> void:
	turn()

func turn()->void:
	$Tween.interpolate_property($Sprite,"rotation_degrees", 0.0, 359.99, 5, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	turn()

func _on_key_body_entered(body: Node) -> void:
	if body is Player:
		MANAGER.emit_signal_key()
		queue_free()
