extends Area2D

# creates a new random number generator and set it to rng variable
var rng = RandomNumberGenerator.new()

# sets stats node to stats variable
onready var stats = get_node("/root/game/stats")

func _ready():
	
	# randomize seed for random function
	rng.randomize()
	
	# uses cactus_reset() function to reset the cactus
	cactus_reset()
	
	pass


func _process(delta):
	
	# checks if isPlaying variable from stats node is true
	if stats.isPlaying == true:
		
		# moves cactus based off speed and multiplier variable from stats node
		self.position.x = self.position.x - ((stats.speed*stats.multiplier) * delta)
		
		pass
	
	# checks if position is less then -128
	if (self.position.x) < -128:
		
		# uses cactus_reset() function to reset the cactus
		cactus_reset()
		
	pass

# function to reset the cactus
func cactus_reset():
	
	# randomizes the x position
	self.position.x = (rng.randf_range(300, 380))
	
	pass

# function for when a body has entered area2d
func _on_Cactus_body_entered(body):
	
	# checks if the body colliding with balloon is named "Player"
	if body.name == "Player":
		
		# sets isGameover variable from stats to true
		stats.isGameover = true
	
	pass
