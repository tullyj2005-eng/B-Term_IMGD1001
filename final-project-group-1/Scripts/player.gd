extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var total_jumps = 2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_wings: AnimatedSprite2D = $AnimatedSprite2D_wings

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Refill jumps
	if is_on_floor():
		total_jumps = 2
		
	# Handle jump
	if Input.is_action_just_pressed("jump") and (total_jumps > 0):
		velocity.y = JUMP_VELOCITY
		total_jumps -= 1
		# Play the wingflap animation behind the player
		animated_sprite_wings.visible = true
		animated_sprite_wings.frame = 0
		animated_sprite_wings.play("wings")
	
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
