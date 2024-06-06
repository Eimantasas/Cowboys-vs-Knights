extends "res://Scenes/Projectiles/dynamite.gd"

func _ready():
	$Explosion.visible = false
	$Timer.start()
	speed = 1000
	damage = GameData.tower_data["DemomanT3"]["damage"]

func _process(delta):
	position += direction * speed * delta
