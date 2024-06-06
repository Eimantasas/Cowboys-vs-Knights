extends PathFollow2D

class_name knight

signal base_damage(dmg)

var speed = 125
var hptotal = 25
var hp = 25
var hptotalstr = str(hptotal)
var hpstr = str(hp)
var mtext = "  /  "
var base_dmg = hp

@onready var health_bar = get_node("HealthBar")
@onready var health_display = get_node("HealthBar/HealthNumbers")

func _ready():
	health_bar.max_value = hptotal
	health_bar.value = hp
	health_bar.set_as_top_level(true)
	health_display.set_as_top_level(true)
	$HealthBar/Name.set_as_top_level(true)
	health_display.text = hpstr + mtext + hptotalstr

func _physics_process(delta):
	if progress_ratio == 1.0:
		base_damage.emit(base_dmg)
		queue_free()
	move(delta)
	
func move(delta):
	set_progress(get_progress() + speed * delta)
	health_bar.set_position(position - Vector2(53, 70))
	health_display.set_position(position - Vector2(35, 75))
	$HealthBar/Name.set_position(position - Vector2(35, -45))
	
func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	hpstr = str(hp)
	base_dmg = hp
	health_display.text = hpstr + mtext + hptotalstr

	if hp <= 0:
		on_destroy()
		var moneygain
		if hptotal < 300:
			moneygain = hptotal
		elif hptotal > 300 and hptotal < 1000:
			moneygain = round(hptotal * 0.65)
		else:
			moneygain = round(hptotal * 0.5)
		GameData.current_money += moneygain

func on_destroy():
	self.queue_free()


func _on_hurt_box_area_entered(area):
	if area is explosion:
		on_hit(GameData.tower_data["DemomanT1"]["damage"])
	elif area is explosionT2:
		on_hit(GameData.tower_data["DemomanT2"]["damage"])
	elif area is explosionT3:
		on_hit(GameData.tower_data["DemomanT3"]["damage"])


func _on_hurt_box_mouse_entered():
	$HealthBar/Name.visible = true


func _on_hurt_box_mouse_exited():
	$HealthBar/Name.visible = false
