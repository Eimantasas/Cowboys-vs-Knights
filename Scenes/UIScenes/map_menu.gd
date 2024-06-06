extends Control



func _on_exit_button_button_up():
	Sfx.clicksfx()
	get_tree().change_scene_to_file("res://Scenes/UIScenes/main_menu.tscn")


func _on_rhodes_button_up():
	Sfx.clicksfx()
	get_tree().change_scene_to_file("res://Scenes/UIScenes/loading_scene.tscn")
