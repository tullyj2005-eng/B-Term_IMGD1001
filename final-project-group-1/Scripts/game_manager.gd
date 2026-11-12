extends Node

var player_health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (player_health >= 0):
		print("GameOver")
		Engine.time_scale = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
