extends RichTextLabel

@export var scroll_speed: float = 60.0 # Pixels per second
var current_scroll: float = 0.0

func _process(delta: float) -> void:
	# get the internal VScrollBar node
	var scrollbar = get_v_scroll_bar()
	
	# increment the scroll position over time
	current_scroll += scroll_speed * delta
	scrollbar.value = current_scroll
	
	# if ESCAPE key is pressed, return to main menu
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
