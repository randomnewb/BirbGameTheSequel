extends Node

var MainInstances = ResourceLoader.MainInstances

func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)
	MainInstances.Player.connect("player_died", self, "_on_Player_player_died")

func _on_Player_player_died():
	print("Game Over, add reset code")
