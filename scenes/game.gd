extends Node2D

# sets variables for game-specific values
var highscore = 0
var highscoreExists = false
var score = 0
var base_speed = 100
var speed = base_speed
var multiplier = 1
#var isDragPlaying = false

# 0 = title, 1 = playing, 2 = gameover
var state = 0

# sets core node to core variable
onready var core = get_node("/root/Core")


func _process(_delta):
	
	# checks the current game state
	match(state):
		
		# if the games state is currently 0, or main menu
		0:
			# checks if input_flap is pressed and if the window is focused
			if Input.is_action_just_pressed("input_flap") and OS.is_window_focused():
		
				# sets isPlaying to true and sets visibility for both title and score nodes
				state = 1
		
		# if the games state is currently 2, or gameover
		2:
	
			# checks if input_flap is pressed and window is focused
			if Input.is_action_just_pressed("input_flap") and OS.is_window_focused():
				
				# checks if highscoreExists is true
				if highscoreExists == true:
					
					# checks if score is bigger then highscore, if so then save score using saveScore() function
					if score > highscore:
						
						core.saveScore(score)
				
				else:
					
					# saves score using saveScore() function if the highscore doesn't exist
					core.saveScore(score)
				
				# reloads game scene
				if get_tree().change_scene("res://scenes/game.tscn") != 0:
					print("scene is missing!")
			
			# sets multiplier to 1, stopping further movement
			multiplier = 1
			
			# decreasing speed over time
			speed -= (speed/18)
			
			# checks if speed is at a certain point, if so then stop movement entirely
			if speed < 18 and speed > 0:
				
				speed -= 1
				#$drag.play()
				
			# for sfx when player drags on the player, unused :p
			#if speed > 0 and isDragPlaying == false:
			#	$drag.play()
			#	isDragPlaying = true

			#if speed == 0:
			#	$drag.stop()
			
			
	pass

# function to add a point
func addPoint():
	
	# add 1 to score, and add 0.06 to multiplier
	score += 1
	multiplier += 0.06
	
	pass
