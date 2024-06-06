extends "res://Scenes/Enemies/Squire.gd"

func _ready():
	speed = 70
	hptotal = 800
	hp = 800
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
	health_bar.set_position(position - Vector2(53, 70))
	health_display.set_position(position - Vector2(45, 75))
	$HealthBar/Name.set_position(Vector2(21, 190))

