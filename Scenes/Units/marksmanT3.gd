extends "res://Scenes/Units/units.gd"

@onready var fire_sounds = $FireSound


func _on_tower_shape_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		get_node("Range/RangeDisplay").visible = true
		get_node("U/UpgradePopup").visible = true
		get_node("Range/RangeDisplay").global_position = self.position + Vector2(-400, -400)
		get_node("U/UpgradePopup").global_position = self.position + Vector2(50, -150)
	
func _on_fire_sound():
	fire_sounds.play()


func _on_outer_tower_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		get_node("Range/RangeDisplay").visible = false
		get_node("U/UpgradePopup").visible = false
