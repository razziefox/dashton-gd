extends KinematicBody2D

# sets variables for player physics
export(int) var max_speed = 100
export(int) var gravity = 214
export(int) var jump_force = 108

# sets stats node to variable
onready var stats = get_node("/root/game/stats")

# sets variables for both motion and landed, landed being true
var motion = Vector2.ZERO
var landed = true

# sets 'hit' variable to false
var hit = false

# sets variables for child nodes
onready var _animated_sprite = $AnimatedSprite

	
func _process(_delta):
	
	#checks if isGameover variable from stats node is true and hit variable isn't true
	if stats.isGameover == true and hit != true:
		
		#play 'hurt' animation
		_animated_sprite.play("hurt")
		
		#play 'hurt' soundfx
		$Hit.play()
		
		#set hit to true
		hit = true
	
	pass

func _physics_process(delta):

	# checks if hit variable isn't true
	if hit != true:
		
		# executes both player_input() and player_animation() function
		player_input()
		player_animation()

	# limits player fall speed
	if motion.y >= jump_force:
		motion.y = jump_force
	
	# prevents the player from flying above the screen	
	if position.y <= 4:
		motion.y = 10
	
	# gravity
	motion.y += gravity * delta
	
	# sets motion with move and slide
	motion = move_and_slide(motion, Vector2.UP)

	pass
	
func player_input():

	# if player presses the flap button with enough flaps, then fly
	if Input.is_action_just_pressed("input_flap") and stats.isGameover == false and OS.is_window_focused():
		motion.y = -jump_force
		$Flap.play()
	
	# if the player is on the ground and hasn't landed, then refresh flaps
	if is_on_floor() and landed != true:

		#set landed to true
		landed = true

	pass
	
func player_animation():

	# checks if player has had motion.y increased
	if motion.y < 0 and !is_on_floor():
		_animated_sprite.play("flap")
		landed = false
	
	# checks if motion.y is below zero
	if motion.y > 0 and !is_on_floor():
		_animated_sprite.play("fall")
		landed = false
		
	# checks if player is walking
	if hit != true and is_on_floor():
		_animated_sprite.play("walk")

	pass
