extends PathFollow2D

signal base_damage(dmg)

var speed = 20
var hptotal = 50000
var hp = 50000
var hptotalstr = str(hptotal)
var hpstr = str(hp)
var mtext = "  /  "
var base_dmg = hp

@onready var peicon = get_node("PestilenceIcon")
@onready var health_bar_2 = get_node("HealthBar2")
@onready var health_display_2 = get_node("HealthNumbers")
@onready var pestilencename = get_node("PName")


func _ready():
	health_bar_2.max_value = hptotal
	health_bar_2.value = hp
	health_bar_2.set_as_top_level(true)
	health_display_2.set_as_top_level(true)
	pestilencename.set_as_top_level(true)
	peicon.set_as_top_level(true)
	$SpeedUp.set_as_top_level(true)
	health_display_2.text = hpstr + mtext + hptotalstr
	health_bar_2.set_position(Vector2(410, 630))
	health_display_2.set_position(Vector2(520, 639))
	pestilencename.set_position(Vector2(555, 591))
	peicon.modulate.a = 0
	health_display_2.modulate.a = 0
	health_bar_2.modulate.a = 0
	pestilencename.modulate.a = 0

func _physics_process(delta):
	if peicon.modulate.a < 1:
		peicon.modulate.a += 0.005
	if health_display_2.modulate.a < 1:
		health_display_2.modulate.a += 0.005
	if health_bar_2.modulate.a < 1:
		health_bar_2.modulate.a += 0.005
	if pestilencename.modulate.a < 1:
		pestilencename.modulate.a += 0.005
	if progress_ratio == 1.0:
		base_damage.emit(base_dmg)
		queue_free()
	move(delta)
	
func move(delta):
	set_progress(get_progress() + speed * delta)
	$SpeedUp.set_position(position - Vector2(75, 150))
	
func on_hit(damage):
	hp -= damage
	health_bar_2.value = hp
	hpstr = str(hp)
	base_dmg = hp
	health_display_2.text = hpstr + mtext + hptotalstr
	if hp <= 40000:
		speed = 30
		$SpeedUp.visible = true
		var tween = create_tween()
		tween.tween_property($SpeedUp, "position", position - Vector2(75, 200), 1)
		tween.parallel().tween_property($SpeedUp, "modulate:a", 0, 1)
		await get_tree().create_timer(1).timeout
	if hp <= 30000:
		speed = 40
		damage = damage * 0.75
	if hp <= 15000:
		speed = 60

	if hp <= 0:
		on_destroy()

func on_destroy():
	speed = 0
	GameData.gamewon = true
	self.queue_free()


func _on_hurt_box_area_entered(area):
	if area is explosion:
		on_hit(GameData.tower_data["DemomanT1"]["damage"] * 0.5)
	elif area is explosionT2:
		on_hit(GameData.tower_data["DemomanT2"]["damage"] * 0.5)
	elif area is explosionT3:
		on_hit(GameData.tower_data["DemomanT3"]["damage"] * 0.5)
