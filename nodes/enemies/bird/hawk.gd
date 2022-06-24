extends Area2D

# sets speed variable to 160
var speed = 160

# sets core node to core variable
onready var core = get_node("/root/Core")

# sets game node to game variable
onready var game = get_node(core.fetch_game())

# sets balloon node to balloon variable
onready var balloon = get_node_or_null(core.fetch_node("items/balloons/Balloon"))


func _ready():
	
	# reset the hawks position
	hawk_reset()
	
	pass

func _process(delta):
	
	# checks if the game state is either 1 or 2 (playing or gameover)
	if game.state == 1 || game.state == 2:
		
		# update hawks position to make it move
		self.position.x = self.position.x - ((speed*game.multiplier) * delta)
		
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
	self.position.y = (core.rng.randf_range(8, 116))
	
	pass


# function to run whenever a body is colliding with hawk
func _on_Hawk_body_entered(body):
	
	# checks if the bodies name is "player"
	if body.name == "Player":
		
		# runs the player_hit() function from the player node
		body.player_hit()
		
	pass
