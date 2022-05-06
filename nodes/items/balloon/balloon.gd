extends Node2D

# creates a new random number generator and set it to rng variable
var rng = RandomNumberGenerator.new()

# sets stats node to stats variable
onready var stats = get_node("/root/game/stats")

func _ready():
	
	# randomize seed for random function
	rng.randomize()
	
	# uses balloon_reset() function to reset the balloon
	balloon_reset()
	
	pass

func _process(delta):
	
	# checks if isPlaying variable from stats node is true
	if stats.isPlaying == true:
		
		# moves balloon based off speed and multiplier variable from stats node
		self.position.x = self.position.x - ((stats.speed*stats.multiplier) * delta)
	
	# checks if position is less then -128
	if (self.position.x) < -128:
		
		# uses balloon_reset() function to reset the balloon
		balloon_reset()
	
	pass

# function to reset the balloon
func balloon_reset():
	
	# resets the x position and randomizes y position
	self.position.x += (128*4)
	self.position.y = (rng.randf_range(8, 104))
	
	# plays idle animation
	$Area2D/AnimatedSprite.play("idle")
	$AnimationPlayer.play()
	
	pass

# function for when the balloon pops
func balloon_pop():
	
	# stops floating animation
	$AnimationPlayer.stop()
	
	# plays pop animation
	$Area2D/AnimatedSprite.play("pop")
	$Pop.play()
	
	# use addPoint() function from stats node to add a point
	stats.addPoint()
	
	pass

# function for when body has entered area2d
func _on_Area2D_body_entered(body):
	
	# checks if the body colliding with balloon is named "Player"
	if body.name == "Player":
		
		# use balloon_pop() function
		balloon_pop()
	
	pass
