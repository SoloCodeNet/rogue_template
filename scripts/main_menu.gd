extends Control
var level 


func _on_btn_new_pressed() -> void:
	DATAS.life = DATAS.default_life
	MANAGER.change_level(1)
	
func _on_btn_continue_pressed() -> void:
	MANAGER.change_level(DATAS.level)

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
	
func _ready() -> void:
	$VBoxContainer/btn_continue.disabled = DATAS.level == 0
