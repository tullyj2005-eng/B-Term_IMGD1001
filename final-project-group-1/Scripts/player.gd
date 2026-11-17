extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var total_jumps = 2
var in_collider = true
var health = 100
var max_health = 100
var target_frame = 0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_wings: AnimatedSprite2D = $AnimatedSprite2D_wings
@onready var timer: Timer = $Timer
@onready var health_bar: AnimatedSprite2D = $Camera2D/health_bar
@onready var timer_2: Timer = $Timer2


func _ready():
	health_bar.frame_changed.connect(_on_frame_changed)
	# Jump straight to the right frame for starting health (no animation)
	target_frame = get_health_frame()
	health_bar.pause()
	health_bar.frame = target_frame


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


# Health Bar - it should tick down through the animation depending on how much health the player has
func damaged(damage):
	health = max(health - damage, 0)
	update_health_bar()


# Frame 0 = full health, last frame = empty
func get_health_frame() -> int:
	var last_frame = health_bar.sprite_frames.get_frame_count(health_bar.animation) - 1
	var missing = 1.0 - float(health) / max_health
	return roundi(missing * last_frame)


func update_health_bar():
	if health <= 0:
		Engine.time_scale = 0.5
		collision_shape_2d.disabled = true
		timer_2.start()
	target_frame = get_health_frame()
	if target_frame > health_bar.frame:
		health_bar.play(health_bar.animation)            # losing health
	elif target_frame < health_bar.frame:
		health_bar.play_backwards(health_bar.animation)  # healing
	else:
		health_bar.pause()                               # already there


func _on_frame_changed():
	if health_bar.frame == target_frame:
		health_bar.pause()


# Damage Timer Handling - use this to align when the damage tick happens with the damage animation
func _on_timer_timeout() -> void:
	if in_collider == true:
		damaged(10)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		in_collider = true
		timer.start()
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	in_collider = false


func _on_timer_2_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
