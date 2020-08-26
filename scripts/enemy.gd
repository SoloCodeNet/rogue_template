extends KinematicBody2D
class_name Enemy

signal enemy_dead
var initial_speed:= 50.0
var speed:= 0.0
var life:= 5
var directions_list:= [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
var direction:Vector2
var velocity: Vector2
var anims = ["anim1", "anim2", "anim3"]

func _ready() -> void:
	randomize()
	$AnimationPlayer.play(anims[randi()% anims.size()])
	
	direction = random_direction(Vector2.ZERO)
	$change_direction_timer.start(rand_range(0.5,2))
	
func _physics_process(delta: float) -> void:
	if direction.x > 0 : $Sprite.flip_h = true
	if direction.x < 0 : $Sprite.flip_h = false
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		direction = random_direction(direction)
		$change_direction_timer.start(rand_range(0.5,2))

func random_direction(last_direction:Vector2)-> Vector2:
	var temp_list = directions_list.duplicate()
	temp_list.erase(last_direction)
	speed = initial_speed + (rand_range(-100,100))
	return temp_list[randi()%temp_list.size() -1]
	
func hit()-> void:
	life-=1
	$Sprite.modulate = Color("#732ffffff")
	yield(get_tree().create_timer(0.05), "timeout")
	$Sprite.modulate = Color("#fff")
	if life <= 0:
		emit_signal("enemy_dead")
		call_deferred("queue_free")

func _on_change_direction_timer_timeout() -> void:
	$change_direction_timer.wait_time = rand_range(0.5,2)
	direction = random_direction(direction)
