extends Node2D

# sets core node to core variable
onready var core = get_node("/root/Core")

# sets game node to game variable
onready var game = get_node(core.fetch_game())

# sets popped variable to false
var popped = false

func _ready():
	
	# uses balloon_reset() function to reset the balloon
	balloon_reset()
	
	pass

func _process(delta):
	
	# checks if isPlaying variable from stats node is true
	if game.state == 1:
		
		# moves balloon based off speed and multiplier variable from stats node
		self.position.x = self.position.x - ((game.speed*game.multiplier) * delta)
	
	# checks if position is less then -128
	if (self.position.x) < -128:
		
		# uses balloon_reset() function to reset the balloon
		balloon_reset()
	
	pass

# function to reset the balloon
func balloon_reset():
	
	# resets the x position and randomizes y position
	self.position.x += (128*4)
	self.position.y = (core.rng.randf_range(8, 104))
	
	# plays idle animation
	$Area2D/AnimatedSprite.play("idle")
	$AnimationPlayer.play()
	
	# sets popped variable to false
	popped = false
	
	pass

# function for when the balloon pops
func balloon_pop():
	
	# stops floating animation
	$AnimationPlayer.stop()
	
	# plays pop animation
	$Area2D/AnimatedSprite.play("pop")
	
	# plays 'pop' soundfx
	$Pop.play()
	
	# use addPoint() function from stats node to add a point
	game.addPoint()
	
	# sets popped variable to true
	popped = true
	
	pass

# function for when body has entered area2d
func _on_Area2D_body_entered(body):
	
	# checks if the body colliding with balloon is named "Player" and popped variable isn't true
	if body.name == "Player" and popped != true:
		
		# use balloon_pop() function
		balloon_pop()
	
	pass
