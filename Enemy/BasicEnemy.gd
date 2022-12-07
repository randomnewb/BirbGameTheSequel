extends "res://Enemy/Enemy.gd"

export(int) var ACCELERATION = 100

var MainInstances = ResourceLoader.MainInstances

onready var sprite = $Sprite

func _ready():
	pass

func _physics_process(delta):
	var player = MainInstances.Player
	if player != null:
		move_to_player(player, delta)

func move_to_player(player, delta):
	var direction = (player.global_position - global_position).normalized()
	motion += direction * ACCELERATION * delta
	motion = motion.clamped(MAX_SPEED)
	sprite.flip_h = global_position < player.global_position
	motion = move_and_slide(motion)

func _on_Hitbox_body_entered(body) -> void:
	queue_free()

func _on_Hitbox_area_entered(area) -> void:
	queue_free()
