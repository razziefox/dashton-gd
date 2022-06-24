extends Node

# creates a new random number generator and set it to rng variable
var rng = RandomNumberGenerator.new()

# sets file save path to score_file variable
var score_file = "user://data.px"


func _ready():
	
	# randomize seed for random function
	rng.randomize()
	
	pass

func _process(_delta):
	
	# runs function for input shortcuts
	input_shortcut()
	
	pass

func input_shortcut():

	# checks if the game is running on desktop
	if is_platform("desktop"):
		
		# checks if input_exit has been pressed
		if Input.is_action_just_pressed("input_exit") and OS.is_window_focused():
			
			# exit game
			get_tree().quit()
			
		# checks if input_screenshot has been pressed
		if Input.is_action_just_pressed("input_screenshot") and OS.is_window_focused():
		
			# sets the data received from viewport to the image variable
			var image = get_viewport().get_texture().get_data()
			
			# flips image from the y-axis, this fixes the way its flipped
			image.flip_y()
			
			# sets new directory to dir variable
			var dir = Directory.new()
			
			# checks if screenshots directory exists
			if dir.file_exists("user://screenshots/") != true:
				
				# opens game folder and creates screenshots folder
				dir.open("user://")
				dir.make_dir("screenshots")
			
			# saves screenshot
			image.save_png("user://screenshots/" + str(round(rng.randf_range(1000000, 9999999))) + ".png")
			
	# checks if game is running on desktop or web
	if is_platform("desktop") or is_platform("web"):
		
		# checks if input_fullscreen has been pressed and isMobile() returns false
		if Input.is_action_just_pressed("input_fullscreen") and OS.is_window_focused():
			
			# toggles fullscreen
			OS.window_fullscreen = !OS.window_fullscreen

	pass
	
# allows you to fetch a node
func fetch_node(path):
	
	# returns path of a specific node
	return str("/root/game/" + path)
	
	pass
	
# allows you to fetch the game node
func fetch_game():
	
	# returns path leading to the game node
	return str("/root/game/")
	pass

# function to save the score from value given
func saveScore(func_score):
	
	# sets a new file to file variable
	var file = File.new()
	
	# opens the save file, then writes to it
	file.open(score_file, File.WRITE)
	file.store_var(func_score)
	file.close()
	
	pass

# fetches the platform the game is running on
func get_platform():
	
	# checks if OS has the name "Android" or "iOS"
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		
		# checks if the OS has "tv" in the name
		if "tv" in OS.get_model_name().to_lower():
			
			# returns back the string "tv"
			return "tv"
			
		else:
			
			# returns back the string "mobile"
			return "mobile"
			
	# if platform is not mobile or tv
	else:
		
		# checks if the OS has the name "HTML5"
		if OS.get_name() == "HTML5":
			
			# returns back the string "web"
			return "web"
		
		else:
			
			# returns back the string "desktop"
			return "desktop"
	
	pass

# function to check if the game is running on a specific platform
func is_platform(platform):
	
	# checks if the platform variable matches in line with the name of the platform the game is running on
	if platform.to_lower() == get_platform():
		return true
	else:
		return false
	
	pass
