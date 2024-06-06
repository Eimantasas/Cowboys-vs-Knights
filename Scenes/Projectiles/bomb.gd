extends "res://Scenes/Projectiles/dynamite.gd"

func _ready():
	$Explosion.visible = false
	$Timer.start()
	speed = 800
	damage = GameData.tower_data["DemomanT2"]["damage"]

func _process(delta):
	position += direction * speed * delta
