extends KinematicBody2D
class_name Player

export(float) var speed:= 100.0

onready var bullet = preload("res://prefabs/bullet.tscn")
var direction:= Vector2.ZERO
var velocity:= Vector2.ZERO
var action1:= false
var action2:= false
var cooldown:= false
var is_god:= false

func _physics_process(_delta: float) -> void:
	loop_input()
	loop_action()
	test_anim()
	velocity = move_and_slide(velocity)
	
func loop_input()-> void:
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down")  - Input.get_action_strength("up")
	).normalized()
	action1 = Input.is_action_just_pressed("action1")
	action2 = Input.is_action_pressed("action2")

func loop_action():
	if action1:
		velocity =  direction * (speed*2.5)
	else:
		velocity = lerp(velocity, direction * speed, 0.15)
		
	if action2 and not cooldown and direction != Vector2.ZERO:
		cooldown = true
		var b = bullet.instance()
		get_parent().add_child(b)
		b.fire(self.global_position, direction)
		yield(get_tree().create_timer(0.15),"timeout")
		cooldown = false
		
func test_anim()-> void:
	if direction == Vector2.ZERO:
		play_anim("idle")
		
	if direction.y != 0.0:
		play_anim("down" if direction.y > 0.0 else "top")
		
	if direction.x != 0.0:
		play_anim("right" if direction.x > 0.0 else "left")
		
func play_anim(value) -> void:
	if $AnimationPlayer.current_animation != value:
		$AnimationPlayer.play(value)

func hit()-> void:
	pass

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Enemy and not is_god:
		is_god = true
		$invicibiliy.start(0.5)
		var enemy: Enemy = body
		velocity = (enemy.global_position - self.global_position).normalized() * -500
		$Sprite.modulate = Color("#32ffffff")
		MANAGER.change_life(-1)

func _on_invicibiliy_timeout() -> void:
	$Sprite.modulate = Color("#fff")
	is_god = false
