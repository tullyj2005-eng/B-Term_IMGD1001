extends CharacterBody2D

@export var speed := 100.0
@export var sight_range := 200.0  
@export var stop_distance := 10.0   

@onready var raycast: RayCast2D = $RayCast2D   
@onready var detect_player: CollisionShape2D = $Detect_Player
@onready var timer: Timer = $Timer
@onready var pause_button = $Camera2D/Button
@onready var ray_right: RayCast2D = $RayCastRight
@onready var ray_left: RayCast2D = $RayCastLeft
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var finished_attack = 1
var target: Node2D = null


func _ready() -> void:
	ray_right.enabled = true
	ray_left.enabled = true
	ray_right.add_exception(self)
	ray_left.add_exception(self)



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if target == null:
		return

	raycast.target_position = raycast.to_local(target.global_position)
	raycast.force_raycast_update()

	if raycast.is_colliding() and raycast.get_collider() == target:
		# Player is within range and not blocked by obstacles
		pass

	var player := find_player()

	if player:
		var dx := player.global_position.x - global_position.x
		sprite.flip_h = dx < 0.0   # always face the player
		
		if abs(dx) <= 35:
			finished_attack = 0
			attack_player()
		elif (finished_attack == 1):
			pathfind(dx)
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		sprite.play("Idle")

	move_and_slide()

func find_player() -> Node2D:
	for ray: RayCast2D in [ray_right, ray_left]:
		var hit := ray.get_collider() if ray.is_colliding() else null
		if hit is Node2D and hit.is_in_group("Player"):
			return hit
	return null
	
	
	# States, Attack player and Pathfind to player
func attack_player():
	velocity.x = 0
	sprite.play("Attack")
	await sprite.animation_finished # timer starts in order to force the enemy to finsih attack animation
	finished_attack = 1
	
func pathfind(dx):
	velocity.x = sign(dx) * speed
	sprite.play("Running")
	


	

	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		target = area


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area == target:
		target = null
