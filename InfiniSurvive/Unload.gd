extends Node2D

var loop_pos = 1

func _process(delta):
	Player.unload_x = global_position.x / 32
	Player.unload_y = global_position.y / 32
	#Loop
	if loop_pos == 1:
		position = Vector2(-3200,-2560)
	if loop_pos == 2:
		position = Vector2(-3200,-1920)
	if loop_pos == 3:
		position = Vector2(-3200,-1280)
	if loop_pos == 4:
		position = Vector2(-3200,-640)
	if loop_pos == 5:
		position = Vector2(-3200,0)
	if loop_pos == 6:
		position = Vector2(-3200,640)
	if loop_pos == 7:
		position = Vector2(-3200,1280)
	if loop_pos == 8:
		position = Vector2(-3200,1920)
	if loop_pos == 9:
		position = Vector2(-2560,-2560)
	if loop_pos == 10:
		position = Vector2(-1920,-2560)
	if loop_pos == 11:
		position = Vector2(-1280,-2560)
	if loop_pos == 12:
		position = Vector2(-640,-2560)
	if loop_pos == 13:
		position = Vector2(0,-2560)
	if loop_pos == 14:
		position = Vector2(640,-2560)
	if loop_pos == 15:
		position = Vector2(1280,-2560)
	if loop_pos == 16:
		position = Vector2(1920,-2560)
	if loop_pos == 17:
		position = Vector2(2560,-2560)
	if loop_pos == 18:
		position = Vector2(-2560,2560)
	if loop_pos == 19:
		position = Vector2(-1920,2560)
	if loop_pos == 20:
		position = Vector2(-1280,2560)
	if loop_pos == 21:
		position = Vector2(-640,2560)
	if loop_pos == 22:
		position = Vector2(0,2560)
	if loop_pos == 23:
		position = Vector2(640,2560)
	if loop_pos == 24:
		position = Vector2(1280,2560)
	if loop_pos == 25:
		position = Vector2(1920,2560)
	if loop_pos == 26:
		position = Vector2(2560,2560)
	if loop_pos == 27:
		position = Vector2(3200,-2560)
	if loop_pos == 28:
		position = Vector2(3200,-1920)
	if loop_pos == 29:
		position = Vector2(3200,-1280)
	if loop_pos == 30:
		position = Vector2(3200,-640)
	if loop_pos == 31:
		position = Vector2(3200,0)
	if loop_pos == 32:
		position = Vector2(3200,640)
	if loop_pos == 33:
		position = Vector2(3200,1280)
	if loop_pos == 34:
		position = Vector2(3200,1920)

func _on_Update_Map_timeout():
	if loop_pos < 35:
		loop_pos += 1
	if loop_pos == 35:
		loop_pos = 0
	print(loop_pos)
