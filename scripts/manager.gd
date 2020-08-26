extends Node
var path = "user://savegame.save"
signal get_yellow_key()
signal get_blue_key()
signal next_level(value)

var _err

func emit_signal_key(value= 1) -> void:
	match value:
		1:
			emit_signal("get_yellow_key")
		2:
			emit_signal("get_blue_key")
	
func emit_signal_change_level(value)-> void:
	emit_signal("next_level", value)


func save_game(value)->void:
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_var(value, true)
	file.close()
	
func load_game()-> int:
	var i:= 0
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		i = file.get_var(true)
		file.close()
	return i

func _ready() -> void:
	DATAS.level = load_game()
	_err = connect("next_level", self, "change_level")
	
func change_level(value)-> void:
	DATAS.level = value
	if value == 0: DATAS.life = DATAS.default_life 
	MANAGER.save_game(DATAS.level)
	var file:= File.new()
	var level_path:= "res://scenes/scene_"+ str(DATAS.level) +".tscn"
	if file.file_exists(level_path):
		_err = get_tree().change_scene(level_path)
	else:
		_err = get_tree().change_scene("res://scenes/the_end.tscn")

func player_is_full()-> bool:
	return DATAS.life == DATAS.default_life
	
func change_life(value:int)-> void:
	print(DATAS.life)
	DATAS.life += value
	if DATAS.life <= 0:
		_err = get_tree().change_scene("res://scenes/the_end.tscn")
	
