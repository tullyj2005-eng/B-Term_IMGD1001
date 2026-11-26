extends Control

@onready var button = $"../"

func _on_resume_pressed() -> void:
	button.pauseMenu()

func _on_exit_game_pressed() -> void:
	get_tree().quit()
