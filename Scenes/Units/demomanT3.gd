extends "res://Scenes/Units/units.gd"


func _on_tower_shape_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		get_node("Range/RangeDisplay").visible = true
		get_node("U/UpgradePopup").visible = true
		get_node("Range/RangeDisplay").global_position = self.position + Vector2(-350, -350)
		get_node("U/UpgradePopup").global_position = self.position + Vector2(50, -150)
		$U/UpgradePopup/UP.text = str(GameData.tower_data["DemomanT2"]["price"]) + "$"

func _on_outer_tower_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		get_node("Range/RangeDisplay").visible = false
		get_node("U/UpgradePopup").visible = false
