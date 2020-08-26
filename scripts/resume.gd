extends Control
var paused:= false
var dir:=0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): take_pause()

func _on_btn_resume_pressed() -> void:
	take_pause()
	print("resume")
	
func _on_btn_restart_pressed() -> void:
	take_pause()
	DATAS.life = DATAS.default_life
	var _err = get_tree().reload_current_scene()
	print("restart")
	
func _on_btn_return_pressed() -> void:
	take_pause()
	var _err  = get_tree().change_scene("res://scenes/main_menu.tscn")
	print("return")
	
func take_pause()->void:
	paused = !paused
	if paused: dir = 0
	get_tree().paused = paused
	visible = paused






