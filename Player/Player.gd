extends KinematicBody2D

const SlashProjectile = preload("res://Effect/Slash.tscn")

var PlayerStats = ResourceLoader.PlayerStats

export (int) var ACCELERATION = 500
export (int) var MAX_SPEED = 80
export (int) var FRICTION = 500

onready var playerSprite = $Sprite

enum {
	MOVE,
	ATTACK,
}

var state = MOVE
var velocity = Vector2.ZERO
var facing = 1

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta):
	match state:
		MOVE:
			var input_vector = get_input_vector()
			apply_movement(input_vector, delta)
			update_animations(input_vector)
		ATTACK:
			slash()

func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	return input_vector

func apply_movement(input_vector, delta):
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()

func move():
	velocity = move_and_slide(velocity)

func update_animations(input_vector):
	if input_vector.x != 0:
		facing = sign(input_vector.x)
	
	if facing == 1:
		playerSprite.flip_h = true
	elif facing == -1:
		playerSprite.flip_h = false

func slash():
	velocity = Vector2.ZERO
	var slash_position = global_position
	if facing > 0:
		slash_position = Vector2(global_position.x + 30, global_position.y)
	elif facing < 0:
		slash_position = Vector2(global_position.x - 30, global_position.y)
	var slash = Utils.instance_scene_on_main(SlashProjectile, slash_position)
	slash.get_node("Sprite").scale.x = -facing
	state = MOVE

func _on_Hurtbox_hit(damage) -> void:
	print("Took damage")
