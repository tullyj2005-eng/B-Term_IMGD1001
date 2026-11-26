extends Control

# when "Start" button is pressed, change scene to the controls tutorial
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/controls_screen.tscn")

# when "Version Notes" button is pressed, change scene to the version notes
func _on_version_notes_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/version_notes.tscn")

# when "Credits" button is pressed, change scene to the credits
func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits_screen.tscn")

# when "Exit Game" button is pressed, exit the game
func _on_exit_button_pressed() -> void:
	get_tree().quit()
