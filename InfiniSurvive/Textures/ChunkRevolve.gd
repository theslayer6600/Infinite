extends Node2D

func _process(delta):
	global_position = Vector2(stepify(Player.player_location.x, 640), stepify(Player.player_location.y, 640))
