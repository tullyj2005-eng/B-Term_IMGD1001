extends RichTextLabel

func _process(delta: float) -> void:
	# if ESCAPE key is pressed, return to main menu
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
