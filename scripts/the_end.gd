extends Control

func _ready() -> void:
	if DATAS.life  <= 0:
		$vbox/Label.text = "Game Over"
		$vbox/btn_retry.visible = true
	else:
		$vbox/Label.text = "The End"
		$vbox/btn_retry.visible = false

func _on_btn_return_pressed() -> void:
	var _err = get_tree().change_scene("res://scenes/main_menu.tscn")

func _on_btn_retry_pressed() -> void:
	DATAS.life = DATAS.default_life
	MANAGER.change_level(DATAS.level)
