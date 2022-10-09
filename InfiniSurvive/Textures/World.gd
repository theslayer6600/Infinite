extends Node2D

export(Script) var game_save_class #Game Save Code
var last_save_pos
var player_position_x_min = Player.load_x_min
var player_position_x_max = Player.load_x_max
var player_position_y_min = Player.load_y_min
var player_position_y_max = Player.load_y_max
var chunk_data = [] #The chunks tile data
var chunk_data_cache = [] #The chunks tile data
var how_many_pixels_snap
var world_size = 100 #Size Of The World
var chunk_size = 20 #Size Of Chunks make sure this is dividable by the world size or you can get some weird bugs
var world_type = 0 #Type i am going to use when im developing the game [SOURCE CODE WILL NOT BE UPLOADED IT WILL BE MY OWN PROJECT]
var load_x_min = 0 #From 0
var load_x_max = 0 #Saves how large your world is to save
var load_y_min = 0 #From 0
var load_y_max = 0 #Saves how large your world is to save
var unload_x_min = 0 #From 0
var unload_x_max = 0 #Saves how large your world is to save
var unload_y_min = 0 #From 0
var unload_y_max = 0 #Saves how large your world is to save
var x_gen = 0 #What stage of gen the x axis should generate
var y_gen = 0 #What stage of gen the y axis should generate
onready var generation_iter = world_size/chunk_size #How Many Chunks can fit. [world size]400/[chunk size]100 = 4 
var time = 0 #Time
var debug_time = 0 #Debug Time
var elapsed = 0 #Elapsed Time
var x_minimum = 0 #Positions of generating area
var x_maximun = 0 #Positions of generating area
var y_minimum = 0 #Positions of generating area
var y_maximun = 0 #Positions of generating area
var unload_left_min
var unload_left_max
var world_save


func _ready():
	how_many_pixels_snap = chunk_size * 32
	Player.snap = how_many_pixels_snap
	print(how_many_pixels_snap)
	var dir = Directory.new()
	if dir.dir_exists("user://World_Save/"): #Checks if world is made if is made deletes generator timer
		pass
	$Generate_Chunk.queue_free()
	time = OS.get_unix_time()
	randomize()
	dir.rename("user://Cache", "user://Cache_OLD" + str(rand_range(-999999999999999999, 999999999999999999)))

func _notification(quit):
	if quit == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit()

func _process(delta):
	var dir = Directory.new()
	unload_x_min = Player.unload_x
	unload_x_max = Player.unload_x + chunk_size
	unload_y_min = Player.unload_y
	unload_y_max = Player.unload_y + chunk_size
	load_x_min = Player.load_x
	load_x_max = Player.load_x + chunk_size
	load_y_min = Player.load_y
	load_y_max = Player.load_y + chunk_size
	if Player.load_x_min > 0:
		player_position_x_min = Player.load_x_min
	if Player.load_x_max > 0:
		player_position_x_max = Player.load_x_max
	if Player.load_y_min > 0:
		player_position_y_min = Player.load_y_min
	if Player.load_y_max > 0:
		player_position_y_max = Player.load_y_max
	if Input.is_action_just_pressed("load"): #Click key to load
		load_world()
	if Input.is_action_just_pressed("Check_Cur_Fors"): #Click key to save
		save_world()
	if Input.is_action_just_pressed("Check_Cur_Fors"):
		print(load_x_min," ",load_y_min)
	#Get The For in [X and Y]
	x_maximun = x_gen * chunk_size + chunk_size
	x_minimum = x_maximun - chunk_size
	y_maximun = y_gen * chunk_size + chunk_size
	y_minimum = y_maximun - chunk_size
	debug_time = OS.get_unix_time()
	elapsed = time - debug_time

func _on_Load_Next_Chunk_timeout():
	pass
	#print("X_Gen", x_gen)
	#print("Y_Gen", y_gen)
	#print(elapsed)
	#if x_gen >= generation_iter and y_gen < generation_iter: #Itterates through the generation axis
		#x_gen = -1
		#y_gen += 1
	#for x in range(x_minimum, x_maximun): #Generates in this range on x
		#for y in range(y_minimum, y_maximun): #Generates in this range on y
			#$Tiles.set_cell(x,y,1) #Sets tile to water [no code for generating worlds yet]
	#if x_gen < generation_iter: #If is lower than generation itter add one to x
		#x_gen += 1
	#else:
		#$Generate_Chunk.queue_free() #Stop timer that controls what chunks is generated [not the best way to do it but works]

func save_world():
	var new_save = game_save_class.new() #Creates a instance of saving script
	
	chunk_data.clear() #Clears array first so file size doesnt double what it is
	
	
	for x in range(load_x_min, load_x_max): #Loops through the world and saves
		chunk_data.append([]) #append the x axis to a seperate array in array
		for y in range(load_y_min, load_y_max): #Loops through the world and saves
			chunk_data[x - load_x_min].append($Tiles.get_cell(x,y)) #Appends the tile data on the x axis [easy to acess]
	
	new_save.tiles = chunk_data #Sets the save to chunk data
	
	var dir = Directory.new() #Directory
	if not dir.dir_exists("user://World_Save/"): #Make directory if directiory doesnt exist
		dir.make_dir_recursive("user://World_Save/") #Makes directory
	
	if dir.file_exists("user://Cache/" + str(unload_x_min) + " " + str(unload_y_min) + ".tres"):
		dir.remove("user://Cache/" + str(unload_x_min) + " " + str(unload_y_min) + ".tres")
	
	ResourceSaver.save("user://World_Save/World_Data" + str(load_x_min) + " " + str(load_y_min) + ".tres",new_save) #Saves [Gonkee [old] made this code it is good and efficient Youtube: https://www.youtube.com/c/Gonkee]

func load_world():
	var dir = Directory.new()
	if not dir.file_exists("user://World_Save/World_Data" + str(load_x_min) + " " + str(load_y_min) + ".tres"): #Checks if file exists
		return false #If not dont load
	
	var world_save = load("user://World_Save/World_Data" + str(load_x_min) + " " + str(load_y_min) + ".tres")
	
	for x in range(load_x_min, load_x_max): #For x in map size + 100 load
		for y in range(load_y_min, load_y_max): #For y in map size + 100 load
			$Tiles.set_cell(x,y,world_save.tiles[x - load_x_min][y - load_y_min]) #Sets tiles in map size

func _on_Save_Chunk_timeout():
	$Update_Map.start()

func _on_Update_Map_timeout():
	var new_save = game_save_class.new()
	var last_pos = Vector2(load_x_min, load_y_max)
	var dir = Directory.new()
	for x in range(unload_x_min, unload_x_max): #Generates in this range on x
		for y in range(unload_y_min, unload_y_max): #Generates in this range on y
			if $Tiles.get_cell(x,y) > 0:
				$Tiles.set_cell(x, y, -1)
	if dir.file_exists("user://World_Save/World_Data" + str(load_x_min) + " " + str(load_y_min) + ".tres"): #Checks if world is made if is made deletes generator timer
		if last_save_pos != last_pos:
			if not dir.file_exists("user://Cache/" + str(load_x_min) + " " + str(load_y_min) + ".tres"):
				dir.make_dir_recursive("user://Cache")
				load_world()
				ResourceSaver.save("user://Cache/" + str(load_x_min) + " " + str(load_y_min) + ".tres", new_save)
				last_save_pos = last_pos
				print("loaded")
			if dir.file_exists("user://Cache/" + str(unload_x_min) + " " + str(unload_y_min) + ".tres"):
				dir.remove("user://Cache/" + str(unload_x_min) + " " + str(unload_y_min) + ".tres")
		save_world()
		return true
	if not dir.file_exists("user://World_Save/World_Data" + str(load_x_min) + " " + str(load_y_min) + ".tres"):
		for x in range(load_x_min, load_x_max): #Generates in this range on x
			for y in range(load_y_min, load_y_max): #Generates in this range on y
				$Tiles.set_cell(x,y,1) #Sets tile to water [no code for generating worlds yet]
		save_world()
