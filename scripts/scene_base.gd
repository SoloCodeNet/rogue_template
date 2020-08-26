extends Node2D
var paused:= false
var normal_key_position:Vector2
var key_find:=false
var enemy_count:int

func _ready() -> void:
	normal_key_position = $key.global_position
	$key.global_position += Vector2(-100000, -100000)
	$screen/label.text = "level " + str(DATAS.level)
	$screen/ProgressBar.max_value = DATAS.default_life
	var _err = MANAGER.connect("get_yellow_key", self, "get_key")
	_err  = $exit.connect("no_key", self, "miss_key")
	connect_enemys()
	limit_camera()
	
	
func limit_camera()-> void:
	var rect_cam = $walls_collision.get_used_rect() 
	$player/Camera2D.limit_left    = rect_cam.position.x
	$player/Camera2D.limit_top     = rect_cam.position.y
	$player/Camera2D.limit_right   = rect_cam.size.x * $walls_collision.cell_size.x
	$player/Camera2D.limit_bottom  = rect_cam.size.y * $walls_collision.cell_size.y
	
func connect_enemys()-> void:
	enemy_count = $list_enemys.get_child_count()
	$screen/lbl_count.text = "Enemies : " + str(enemy_count)
	for enemy_object in $list_enemys.get_children():
		var enemy:Enemy = enemy_object
		var _err = enemy.connect("enemy_dead", self, "count_enemy")
	
func get_key():
	$screen/label.text = "door open !"
	
func miss_key(value):
	$screen/label.text = "The door is closed !" if value else "level " + str(DATAS.level)

func count_enemy()-> void:
	enemy_count -=1
	$screen/lbl_count.text = "Enemies : " + str(enemy_count)
	if enemy_count ==0:
		$key.global_position = normal_key_position
		$screen/label.text = "Level Cleared, find the key !"
func _process(_delta: float) -> void:
	$screen/ProgressBar.value = DATAS.life
