extends Control

func _process(delta: float) -> void:
	# if ENTER key is pressed, return to main menu
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene_to_file("res://Scenes/Levels/test_level.tscn")
