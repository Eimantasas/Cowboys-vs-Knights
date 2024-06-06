extends "res://Scenes/Enemies/Squire.gd"

func _ready():
	speed = 50
	hptotal = 12500
	hp = 12500
	hptotalstr = str(hptotal)
	hpstr = str(hp)
	mtext = "  /  "
	base_dmg = hp
	health_bar.max_value = hptotal
	health_bar.value = hp
	health_bar.set_as_top_level(true)
	health_display.set_as_top_level(true)
	health_display.text = hpstr + mtext + hptotalstr


func move(delta):
	set_progress(get_progress() + speed * delta)
	health_bar.set_position(position - Vector2(53, 80))
	health_display.set_position(position - Vector2(45, 80))
	$HealthBar/Name.set_position(Vector2(-8, 202))

func _on_hurt_box_area_entered(area):
	if area is explosion:
		on_hit(GameData.tower_data["DemomanT1"]["damage"] * 0.5)
	elif area is explosionT2:
		on_hit(GameData.tower_data["DemomanT2"]["damage"] * 0.5)
	elif area is explosionT3:
		on_hit(GameData.tower_data["DemomanT3"]["damage"] * 0.5)
