extends Control

func _on_exit_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/UIScenes/main_menu.tscn")
	Sfx.clicksfx()
