extends Control

var scene_load_status = 0


func _ready():
	$AnimationPlayer.play("loadinganim")
	ResourceLoader.load_threaded_request("res://Scenes/MainScenes/game_scene.tscn")

func _process(_delta):
	scene_load_status = ResourceLoader.load_threaded_get_status("res://Scenes/MainScenes/game_scene.tscn")
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var thegamescene = ResourceLoader.load_threaded_get("res://Scenes/MainScenes/game_scene.tscn")
		get_tree().change_scene_to_packed(thegamescene)
