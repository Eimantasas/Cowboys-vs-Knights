extends Control



func _on_play_button_up():
	get_tree().change_scene_to_file("res://Scenes/UIScenes/map_menu.tscn")
	Sfx.clicksfx()


func _on_encyclopedia_button_up():
	get_tree().change_scene_to_file("res://Scenes/UIScenes/e_menu.tscn")
	Sfx.clicksfx()


func _on_options_button_up():
	get_tree().change_scene_to_file("res://Scenes/UIScenes/options_menu.tscn")
	Sfx.clicksfx()


func _on_quit_button_up():
	Sfx.clicksfx()
	get_tree().quit()
