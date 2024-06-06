extends Node2D

class_name dynamite

signal damaged

var type
var speed = 600
var slowdown = 0
var damage = GameData.tower_data["DemomanT1"]["damage"]
var direction: Vector2 = Vector2.RIGHT

func _ready():
	$Explosion.visible = false
	$Timer.start()
	$speedloss.start()

func _process(delta):
	if speed != 0:
		speed = speed - slowdown
	position += direction * speed * delta


func explode():
	speed = 0
	$DamageShape/CollisionShape2D.set_deferred("disabled", false)
	$AnimationPlayer.play("explosion")
	Sfx.explodesound()
	await (get_tree().create_timer(0.2)).timeout
	$DamageShape/CollisionShape2D.set_deferred("disabled", true)


func _on_speedloss_timeout():
	slowdown = 15


func _on_timer_timeout():
	queue_free()


func _on_body_entered(_body):
	explode()
