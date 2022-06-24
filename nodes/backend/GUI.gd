extends CanvasLayer

# sets core node to core variable
onready var core = get_node("/root/Core")

# sets game node to game variable
onready var game = get_node(core.fetch_game())


func _ready():
	
	# refreshes the GUI's state
	reload_state()
	
	pass

func _process(_delta):
	
	# refreshes the GUI's state
	reload_state()
	
	pass

# reloads the entire GUI's state
func reload_state():

	# checks the current game state
	match(game.state):
		
		# if the game state is 0, or main menu
		0:
			gui_title()
			
		# if the game state is 1, or playing
		1:
			gui_playing()
			
		# if the game state is 2, or gameover
		2:
			gui_gameover()
	
	pass

# title screen gui code
func gui_title():
	
	# sets other gui's to either visible or hidden
	$Title.visible = true
	$Gameover.visible = false
	$Playing.visible = false
	
	# sets new file to file variable
	var file = File.new()
	
	# checks if the score save file exists
	if file.file_exists(core.score_file):
		
		# opens save file and fetches variable to be set as highscore variable
		file.open(core.score_file, File.READ)
		game.highscore = file.get_var()
		file.close()
			
		# sets highscoreExists variable to true
		game.highscoreExists = true
			
		# sets highscore text and makes it visible
		$Title/highscore.set_text("highscore: " + str(game.highscore))
		$Title/highscore.visible = true
			
	else:
		
		# set highscoreExists to false and makes it not visible
		game.highscoreExists = false
		$Title/highscore.visible = false
	
	# checks what platform the game is running on
	match (core.get_platform()):
		
		# if the game is running on desktop
		"desktop":
			$Title/desktop.visible = true
			
		# if the game is running on web
		"web":
			$Title/desktop.visible = true
			
		# if the game is running on mobile
		"mobile":
			$Title/mobile.visible = true
		
		# if the game is running on tv
		"tv":
			$Title/tv.visible = true
			
		# if the game is running on generic
		_:
			$Title/desktop.visible = true
	
	pass

# playing gui code
func gui_playing():
	
	# checks if the title screen gui node exists
	if self.has_node("Title"):
		
		# clear the title screen gui node
		$"Title".queue_free()
	
	# sets other gui's to either visible or hidden
	$Gameover.visible = false
	$Playing.visible = true
	
	# sets score text to whatever is the current score
	$Playing/score.set_text("score: " + str(game.score))
	
	pass
	
func gui_gameover():
	
	# sets other gui's to either visible or hidden
	$Playing.visible = true
	$Gameover.visible = true
	
	# checks what platform the game si running on
	match (core.get_platform()):
		
		# if the game is running on desktop
		"desktop":
			$Gameover/desktop.visible = true
			
		# if the game is running on web
		"web":
			$Gameover/desktop.visible = true
			
		# if the game is running on mobile
		"mobile":
			$Gameover/mobile.visible = true
			
		# if the game is running on tv
		"tv":
			$Gameover/tv.visible = true
			
		# if the game is running on generic
		_:
			$Gameover/desktop.visible = true
	
	pass
