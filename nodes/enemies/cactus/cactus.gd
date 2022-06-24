extends Area2D

# sets the core node to core variable
onready var core = get_node("/root/Core")

# sets game node to game variable
onready var game = get_node(core.fetch_game())


func _ready():
	
	# uses cactus_reset() function to reset the cactus
	cactus_reset()
	
	pass

func _process(delta):
	
	# checks if the game state is either 1 or 2 (playing or gameover)
	if game.state == 1 || game.state == 2:
		
		# moves cactus based off speed and multiplier variable from game node
		self.position.x = self.position.x - ((game.speed*game.multiplier) * delta)
		
		pass
	
	# checks if position is less then -128
	if (self.position.x) < -128:
		
		# uses cactus_reset() function to reset the cactus
		cactus_reset()
		
	pass

# function to reset the cactus
func cactus_reset():
	
	# randomizes the x position
	self.position.x = (core.rng.randf_range(300, 380))
	
	pass

# function for when a body has entered area2d
func _on_Cactus_body_entered(body):
	
	# checks if the body colliding with balloon is named "Player"
	if body.name == "Player":
		
		# runs the player_hit() function from the player node
		body.player_hit()
	
	pass
