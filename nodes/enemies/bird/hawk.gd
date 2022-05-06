extends Area2D

# sets speed variable to 160
var speed = 160

# creates a new random number generator and set it to rng variable
var rng = RandomNumberGenerator.new()

# sets stats and balloon nodes to stats and balloon variable
onready var stats = get_node("/root/game/stats")
onready var balloon = get_node_or_null("/root/game/items/balloons/Balloon")

func _ready():
	
	# randomize seed for random function
	rng.randomize()
	
	# reset the hawks position
	hawk_reset()
	
	pass

func _process(delta):
	
	# checks if isPlaying from stats node is true
	if stats.isPlaying == true:
		
		# update hawks position to make it move
		self.position.x = self.position.x - ((speed*stats.multiplier) * delta)
		
		pass

	# checks if hawks position is less then -128	
	if (self.position.x) < -128:

		# resets hawks position
		hawk_reset()
	
	pass

# function to reset the hawks position
func hawk_reset():
	
	# resets the hawks position
	self.position.x += (128*3)
	
	# randomizes the hawks y-axis
	self.position.y = (rng.randf_range(8, 116))
	
	pass


# function to run whenever a body is colliding with hawk
func _on_Hawk_body_entered(body):
	
	# checks if the bodies name is "player"
	if body.name == "Player":
		
		# set isGameover from stats node to true
		stats.isGameover = true
		
	pass
