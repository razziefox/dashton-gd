extends Node2D

# sets variables for game-specific values
var highscore = 0
var highscoreExists = false
var score = 0
var base_speed = 100
var speed = base_speed
var multiplier = 1
var isGameover = false
var isPlaying = false

# creates a new random number generator and set it to rng variable
var rng = RandomNumberGenerator.new()

# sets score node to score_node
onready var score_node = get_node("/root/game/GUI/score")

# sets file save path to score_file variable
var score_file = "user://data.px"

func _ready():
	
	# randomize seed for random function
	rng.randomize()
	
	# sets new file to file variable
	var file = File.new()
	
	# checks if the score save file exists
	if file.file_exists(score_file):
		
			# opens save file and fetches variable to be set as highscore variable
			file.open(score_file, File.READ)
			highscore = file.get_var()
			file.close()
			
			# sets highscoreExists variable to true
			highscoreExists = true
			
			# sets highscore text and makes it visible
			$Title/highscore.set_text("highscore: " + str(highscore))
			$Title/highscore.visible = true
			
	else:
		
		# set highscoreExists to false and makes it not visible
		highscoreExists = false
		$Title/highscore.visible = false
		
	# checks if game is running on mobile
	if ifMobile() == true:
		
		# set desktop instructions to not be visible
		$Title/desktop.visible = false
		
	else:
		
		# set mobile instructions to not be visible
		$Title/mobile.visible = false
	
	pass

func _process(_delta):
	
	# checks if input_exit has been pressed and isMobile() returns false
	if Input.is_action_just_pressed("input_exit") and ifMobile() != true and OS.is_window_focused():
		
		# exit game
		get_tree().quit()
		
	# checks if input_fullscreen has been pressed and isMobile() returns false
	if Input.is_action_just_pressed("input_fullscreen") and ifMobile() != true and OS.is_window_focused():
		
		# toggles fullscreen
		OS.window_fullscreen = !OS.window_fullscreen
		
	# checks if input_screenshot has been pressed and isMobile() returns false
	if Input.is_action_just_pressed("input_screenshot") and ifMobile() != true and OS.is_window_focused():
		
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
		
	
	# checks if isPlaying variable is false
	if isPlaying == false:
		
		# checks if input_flap is pressed and if the window is focused
		if Input.is_action_just_pressed("input_flap") and OS.is_window_focused():
		
			# sets isPlaying to true and sets visibility for both title and score nodes
			isPlaying = true
			$Title.visible = false
			score_node.visible = true
	
	# checks if isGameover is true
	if isGameover == true:
		
		# checks if input_flap is pressed and window is focused
		if Input.is_action_just_pressed("input_flap") and OS.is_window_focused():
			
			# checks if highscoreExists is true
			if highscoreExists == true:
				
				# checks if score is bigger then highscore, if so then save score using saveScore() function
				if score > highscore:
					
					saveScore(score)
			
			else:
				
				# saves score using saveScore() function if the highscore doesn't exist
				saveScore(score)
			
			# reloads game scene
			if get_tree().change_scene("res://scenes/game.tscn") != 0:
				print("scene is missing!")
		
		# makes gameover text visible
		$Gameover.visible = true
		
		# sets multiplier to 1, stopping further movement
		multiplier = 1
		
		# decreasing speed over time
		speed -= (speed/18)
		
		# checks if speed is at a certain point, if so then stop movement entirely
		if speed < 18 and speed > 0:
			
			speed -= 1
			
	pass

# function to add a point
func addPoint():
	
	# add 1 to score, and add 0.06 to multiplier
	score += 1
	multiplier += 0.06
	
	# refreshes the score text to reflect the current score
	score_node.set_text("score: " + str(score))
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
	
# function to check if game is running on mobile
func ifMobile():
	
	# checks if os name is either android or ios, if so then return true otherwise return false
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		return true
	else:
		return false
	pass
