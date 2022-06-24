extends Node2D

# sets core node to the core variable
onready var core = get_node("/root/Core")

# sets game node to stats variable
onready var game = get_node(core.fetch_game())


func _process(delta):
	
	# moves floor based off speed and multiplier variable from game node
	self.position.x = self.position.x - ((game.speed*game.multiplier) * delta)
	
	# checks if position is less then -128
	if (self.position.x) < -128:
		
		# adds 128*3 to the current x position (do not set the position! will cause misalignment)
		self.position.x += (128*3)
	
	pass
