extends Control

# when the animation is finished, change scene to the main menu
func _on_fade_animation_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
