extends KinematicBody2D

export (int) var ACCELERATION = 500
export (int) var MAX_SPEED = 80
export (int) var FRICTION = 500

onready var playerSprite = $Sprite

enum {
	MOVE,
}

var state = MOVE
var velocity = Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		if input_vector.x > 0:
			playerSprite.flip_h = true
		elif input_vector.x < 0:
			playerSprite.flip_h = false
			
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()

func move():
	velocity = move_and_slide(velocity)
