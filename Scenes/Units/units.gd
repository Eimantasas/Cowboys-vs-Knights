extends Node2D

signal fire_sound
signal upgrade_clicked
signal sell_pressed

var enemy_array = []
var built = false
var enemy
var category
var type
var rready = true
var total_damage = 0


var dynamite_scene: PackedScene = preload("res://Scenes/Projectiles/dynamite.tscn")
var bomb_scene: PackedScene = preload("res://Scenes/Projectiles/bomb.tscn")
var bomb2_scene: PackedScene = preload("res://Scenes/Projectiles/crusher_bomb.tscn")

func _ready():
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[type]["range"]
		self.get_node("U/UpgradePopup/UpgradeB").pressed.connect(on_upgrade_pressed)
		self.get_node("U/UpgradePopup/SellB").pressed.connect(on_sell_pressed)
		self.get_node("U/UpgradePopup/TotalDmg").text = str(total_damage)
		self.get_node("U/UpgradePopup/SellB").text = str("Sell +", GameData.tower_data[type]["price"] * 0.5) + "$"


func _physics_process(_delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		if not get_node("AnimationPlayer").is_playing():
			turn()
		if rready:
			fire()
	else:
		enemy = null


	
func turn():
	get_node("unit").look_at(enemy.position)

func select_enemy(): #Selects the enemy in range that is the farthest along the path
	var enemy_progress_array = [] 
	for i in enemy_array:
		enemy_progress_array.append(i.progress) #adding how many pixels the enemy moved along the path
	var max_progress = enemy_progress_array.max() #finds the enemy who is the farthest along the path, biggest number in enemy progress array
	var enemy_index = enemy_progress_array.find(max_progress)
	enemy = enemy_array[enemy_index]
	
func fire():
	rready = false
	if category == "bullet":
		fire_gun()
		fire_sound.emit()
		enemy.on_hit(GameData.tower_data[type]["damage"])
		total_damage += (GameData.tower_data[type]["damage"])
		self.get_node("U/UpgradePopup/TotalDmg").text = str(total_damage)
		await get_tree().create_timer(GameData.tower_data[type]["rate"]).timeout
	elif category == "projectile":
		throw_projectile()
		var projectile
		if (GameData.tower_data[type]["tier"]) == 1:
			projectile = dynamite_scene.instantiate()
		elif (GameData.tower_data[type]["tier"]) == 2:
			projectile = bomb_scene.instantiate()
			Sfx.cannonsound()
		else:
			projectile = bomb2_scene.instantiate()
			Sfx.cannonsound()
		projectile.position = self.position
		projectile.direction = (enemy.position - self.position).normalized()
		$"../Projectiles".add_child(projectile)
		await get_tree().create_timer(GameData.tower_data[type]["rate"]).timeout
		
	rready = true
	
func fire_gun():
	get_node("AnimationPlayer").play("fire")


func throw_projectile():
	get_node("AnimationPlayer").play("fire")


func _on_range_body_entered(body):
	enemy_array.append(body.get_parent())


func _on_range_body_exited(body):
	enemy_array.erase(body.get_parent())


func on_upgrade_pressed():
	upgrade_clicked.emit()
	Sfx.uptowersound()



func on_sell_pressed():
	self.queue_free()
	var sell_price = round((GameData.tower_data[type]["price"]) * 0.5)
	GameData.current_money += sell_price
	GameData.tower_count -= 1
