extends Area2D
signal no_key

var opened:= false
func _ready() -> void:
	var _err = MANAGER.connect("get_yellow_key", self, "open_yellow_door")

func open_yellow_door():
	$locked.collision_layer = 0
	$Sprite.visible = false
	opened=true

func _on_exit_body_entered(body: Node) -> void:
	if body is Player:
		var next_level = DATAS.level + 1
		MANAGER.emit_signal_change_level(next_level)
#		MANAGER.emit_signal("next_level", next_level)

func _on_Area2D_body_entered(_body: Node) -> void:
	if not opened:
		emit_signal("no_key", true)

func _on_Area2D_body_exited(_body: Node) -> void:
	if not opened:
		emit_signal("no_key", false)
