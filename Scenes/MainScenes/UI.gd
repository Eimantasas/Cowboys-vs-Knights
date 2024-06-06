extends CanvasLayer

@onready var health_bar = $HUD/InfoBar/HealthBar
@onready var pause_play = $HUD/HBoxContainer/PausePlay

func set_tower_preview(tower_type, mouse_position):

	var drag_tower = load("res://Scenes/Units/" + tower_type + ".tscn").instantiate()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("15ff00b8")
	
	var range_texture = Sprite2D.new()
	var scaling = GameData.tower_data[tower_type]["range"] / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://Assets/UI/Buttons/1x/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("15ff00b8")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.set_position(mouse_position)
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0)
	

func update_tower_preview(new_position, color):
	get_node("TowerPreview").set_position(new_position)
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/Sprite2D").modulate = Color(color)


#Game Controls

func _on_pause_play_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().current_wave == 0:
		get_parent().current_wave = 1
		get_parent().start_next_wave()
	else:
		get_tree().paused = true
	pause_play.visible = false


func _on_speed_up_pressed():
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)
		
func update_health_bar(base_health):
	health_bar.max_value = 100
	health_bar.value = base_health
	



func _on_outlaw_mouse_entered():
	$HUD/BuildBar/Outlaw/TowerTitle.visible = true

func _on_outlaw_mouse_exited():
	$HUD/BuildBar/Outlaw/TowerTitle.visible = false


func _on_marksman_mouse_entered():
	$HUD/BuildBar/Marksman/TowerTitle.visible = true


func _on_marksman_mouse_exited():
	$HUD/BuildBar/Marksman/TowerTitle.visible = false


func _on_gunner_mouse_entered():
	$HUD/BuildBar/Gunner/TowerTitle.visible = true


func _on_gunner_mouse_exited():
	$HUD/BuildBar/Gunner/TowerTitle.visible = false


func _on_demoman_mouse_entered():
	$HUD/BuildBar/Demoman/TowerTitle.visible = true


func _on_demoman_mouse_exited():
	$HUD/BuildBar/Demoman/TowerTitle.visible = false
