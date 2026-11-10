extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var total_jump = 2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor():
		total_jump = 2
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (total_jump > 0):
		velocity.y = JUMP_VELOCITY
		total_jump -= 1
		
		
	
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
