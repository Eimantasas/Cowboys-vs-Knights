extends "res://Scenes/Enemies/Squire.gd"

var shieldgone = load("res://Assets/Enemies/1x/Asset 32.png")


func _ready():
	speed = 100
	hptotal = 450
	hp = 450
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
	$HealthBar/Name.set_position(Vector2(23, 190))
	$HealthBar/SpeedUp.set_position(Vector2(23, 75))
	
	
func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	hpstr = str(hp)
	base_dmg = hp
	health_display.text = hpstr + mtext + hptotalstr
	if hp <= 250:
		speed = 180
		$CharacterBody2D/Sprite2D.set_texture(shieldgone)
		$HealthBar/SpeedUp.visible = true
		var tween = create_tween()
		tween.tween_property($HealthBar/SpeedUp, "position", Vector2(15, 25), 0.75)
		tween.parallel().tween_property($HealthBar/SpeedUp, "modulate:a", 0, 0.75)
	if hp <= 0:
		on_destroy()
		var moneygain
		if hptotal < 300:
			moneygain = hptotal
		elif hptotal > 300 and hptotal < 1000:
			moneygain = round(hptotal * 0.65)
		else:
			moneygain = round(hptotal * 0.4)
		GameData.current_money += moneygain
