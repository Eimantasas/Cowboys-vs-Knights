extends "res://Scenes/Units/units.gd"


func _on_tower_shape_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		get_node("Range/RangeDisplay").visible = true
		get_node("U/UpgradePopup").visible = true
		get_node("Range/RangeDisplay").global_position = self.position + Vector2(-200, -200)
		get_node("U/UpgradePopup").global_position = self.position + Vector2(50, -150)
		$U/UpgradePopup/UP.text = str(GameData.tower_data["DemomanT2"]["price"]) + "$"

func _on_outer_tower_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		get_node("Range/RangeDisplay").visible = false
		get_node("U/UpgradePopup").visible = false


func on_upgrade_pressed():
	var build_type = "DemomanT2"
	if GameData.current_money >= GameData.tower_data[build_type]["price"]:
		self.queue_free()
		var new_tower = load("res://Scenes/Units/" + build_type + ".tscn").instantiate()
		new_tower.position = self.position
		new_tower.built = true
		new_tower.type = build_type
		new_tower.category = GameData.tower_data[build_type]["category"]
		GameData.current_money -= GameData.tower_data[build_type]["price"]
		get_parent().add_child(new_tower, true)
