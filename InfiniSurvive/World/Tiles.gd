extends TileMap

func _process(delta):
	if Input.is_action_pressed("Delete"):
		set_cellv(Player.location_of_set, -1)
