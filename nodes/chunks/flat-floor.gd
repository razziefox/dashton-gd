extends Node2D

# sets stats node to stats variable
onready var stats = get_node("/root/game/stats")

func _process(delta):
	
	# moves floor based off speed and multiplier variable from stats node
	self.position.x = self.position.x - ((stats.speed*stats.multiplier) * delta)
	
	# checks if position is less then -128
	if (self.position.x) < -128:
		
		# adds 128*3 to the current x position (do not set the position! will cause misalignment)
		self.position.x += (128*3)
	
	pass
