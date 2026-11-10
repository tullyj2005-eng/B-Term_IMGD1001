extends CharacterBody2D

@export var speed := 60.0
@export var sight_range := 200.0  
@export var stop_distance := 6.0   
@export var debug := true         
 
@onready var ray_right: RayCast2D = $RayCastRight
@onready var ray_left: RayCast2D = $RayCastLeft
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


var last_debug := ""


func _ready() -> void:
	ray_right.target_position = Vector2(sight_range, 0)
	ray_left.target_position = Vector2(-sight_range, 0)
	ray_right.enabled = true
	ray_left.enabled = true
	ray_right.add_exception(self)
	ray_left.add_exception(self)

	



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
 
	var player := find_player()
 
	if player:
		var dx := player.global_position.x - global_position.x
		if abs(dx) > stop_distance:
			velocity.x = sign(dx) * speed
			sprite.flip_h = dx < 0.0
		else:
			velocity.x = 0.0
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
 
	move_and_slide()

func find_player() -> Node2D:
	for ray: RayCast2D in [ray_right, ray_left]:
		var hit := ray.get_collider() if ray.is_colliding() else null
		if hit is Node2D and hit.is_in_group("Player"):
			return hit
	return null
 
 
