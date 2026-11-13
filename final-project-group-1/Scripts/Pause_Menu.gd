extends Button
var pause := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Pause menu below
# Currently if you press the space bar it will automatically pause the game
# by pressing the pause button, this needs to be fixed before the push to git!!
func _on_pressed() -> void:
	if pause == false:
		pause = true
		Engine.time_scale = 0
	elif pause == true:
		pause = false
		Engine.time_scale = 1
