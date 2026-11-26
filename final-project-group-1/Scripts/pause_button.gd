extends Button

@onready var pause_menu: Control = $PauseMenu
var paused = false

# If Pause button is pressed, then enter the "paused" state
func _on_pressed() -> void:
	pauseMenu()

func pauseMenu() -> void:
	if paused == true:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
		get_tree().paused = false
	else:
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()
	
	paused = !paused
