extends Node2D

# sets step variable to 0
var step = 0


func _ready():
	
	# sets timer to 0.3 seconds and starts it
	$Timer.set_wait_time(0.3)
	$Timer.start()
	
	pass

# function for when the timer runs out
func _on_Timer_timeout():
	
	# matches the step with each value to determine what step its at during boot
	match step:
		0:
			# play sfx and makes logo visible
			$bootsfx.play()
			$Logo.visible = true
			
			# sets timer to 0.15 seconds and starts it again
			$Timer.set_wait_time(0.15)
			$Timer.start()
			
		1:
			# makes the loading sprite visible
			$Loading.visible = true
			
			# sets timer to 2 seconds and starts it again
			$Timer.set_wait_time(2)
			$Timer.start()
			
		2:
			
			# stops the timer
			$Timer.stop()
			
			# attempt to load game scene
			if get_tree().change_scene("res://scenes/game.tscn") != 0:
				
				# if the game fails to load the scene
				print("ERROR: scene that was attempted to be loaded is missing!!")
			
				# makes the error sprite visible
				$Error.visible = true
				
				# sets background color to red
				$Background.color = "#ac3232"
				
				# checks if errorsfx is playing
				if $errorsfx.playing != true:
					
					# play errorsfx
					$errorsfx.play()
				
	
	# adds 1 to step variable, showing that it has moved to the next step
	step += 1
	
	pass
