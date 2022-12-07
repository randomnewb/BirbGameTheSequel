extends Node2D

var velocity = Vector2.ZERO

func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	pass

func _on_Hitbox_body_entered(body: Node) -> void:
	pass

func _on_Hitbox_area_entered(area: Area2D) -> void:
	pass
