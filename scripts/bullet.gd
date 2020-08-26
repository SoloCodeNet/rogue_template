extends KinematicBody2D

var vel:Vector2

	
func fire(start_position:Vector2, dir:Vector2)-> void:
	var priority = Vector2(round(dir.x), round(dir.y))
	vel = priority * 400
	global_position = start_position

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(vel* delta)
	if collision:
		if collision.collider is Enemy:
			collision.collider.hit()
		queue_free()
