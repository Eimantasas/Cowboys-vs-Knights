extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

@onready var money_display = $UI/HUD/InfoBar/Money
@onready var base_healthdisplay = $UI/HUD/InfoBar/BaseHealth
@onready var outlawpricetag = $UI/HUD/BuildBar/Outlaw/Pricetag
@onready var marksmanpricetag = $UI/HUD/BuildBar/Marksman/Pricetag
@onready var gunnerpricetag = $UI/HUD/BuildBar/Gunner/Pricetag
@onready var demomanpricetag = $UI/HUD/BuildBar/Demoman/Pricetag
@onready var tower_counter = $UI/HUD/InfoBar/TowerCount



var enemies_in_wave = 0
var current_wave = 0

var gamehappening: bool


var base_health = 100

func _ready():
	gamehappening = true
	GameData.tower_count = 0
	GameData.current_money = GameData.starting_money
	outlawpricetag.text = str(GameData.tower_data["OutlawT1"]["price"]) + "$"
	marksmanpricetag.text = str(GameData.tower_data["MarksmanT1"]["price"]) + "$"
	gunnerpricetag.text = str(GameData.tower_data["GunnerT1"]["price"]) + "$"
	demomanpricetag.text = str(GameData.tower_data["DemomanT1"]["price"]) + "$"
	tower_counter.text = "Towers built: " + str(GameData.tower_count) + "/" + str(GameData.max_tower_count)
	
	base_healthdisplay.text = str(base_health)
	map_node = get_node("Map1")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	

func _process(_delta): # the if statement checks and updates the preview of the tower depending on if we are able to place it
	if build_mode:
		update_tower_preview()
		$UI/HUD/CancelHelp.visible = true
	else:
		$UI/HUD/CancelHelp.visible = false
	money_display.text = str(GameData.current_money)
	tower_counter.text = "Towers built: " + str(GameData.tower_count) + "/" + str(GameData.max_tower_count)
	if GameData.gamewon == true:
		GameData.gamewon = false
		await get_tree().create_timer(4).timeout
		Sfx.bossdeathsfx()
		Transition.change_scene("res://Scenes/UIScenes/victory_screen.tscn")
	
func _unhandled_input(event): #ui_cancel is set to right mouse button, if you click it, you cancel build mode. If you build, you initiate it and cancel build mode
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()
	if Input.is_action_just_pressed("buildoutlaw"):
		initiate_build_mode("Outlaw")
	if Input.is_action_just_pressed("buildmarksman"):
		initiate_build_mode("Marksman")
	if Input.is_action_just_pressed("buildgunner"):
		initiate_build_mode("Gunner")
	if Input.is_action_just_pressed("builddemoman"):
		initiate_build_mode("Demoman")
	if Input.is_action_just_pressed("cancel") and build_mode == true:
		cancel_build_mode()
	if Input.is_action_just_pressed("speedup"):
		if Engine.get_time_scale() == 2.0:
			Engine.set_time_scale(1.0)
		else:
			Engine.set_time_scale(2.0)
		$UI/HUD/HBoxContainer/SpeedUp.button_pressed = !$UI/HUD/HBoxContainer/SpeedUp.button_pressed

#
## Spawning and waves
#

func start_next_wave():
	var wave_data = retrieve_wave_data()
	await (get_tree().create_timer(1)).timeout #time between waves
	spawn_enemies(wave_data)

func retrieve_wave_data(): #retrieves how many enemies in a wave should be there
	var wave_data = []
	## Wave 1 ##
	for i in 10:
		wave_data.append(["Squire", 3])

## Wave 2 ##
	for i in 15:
		wave_data.append(["Squire", 2])
	for i in 1:
		wave_data.append(["Squire", 5])
	for i in 2:
		wave_data.append(["Knight", 4])

## Wave 3 ##
	for i in 15:
		wave_data.append(["Squire", 1])
	for i in 3:
		wave_data.append(["Knight", 4])
	for i in 10:
		wave_data.append(["Squire", 1])
	for i in 5:
		wave_data.append(["Knight", 4])
	

## Wave 4 ##
	for i in 8:
		wave_data.append(["Knight", 3])
	for i in 3:
		wave_data.append(["Templar", 4])
	for i in 10:
		wave_data.append(["Knight", 2])
	
## Wave 5 ##
	for i in 20:
		wave_data.append(["Squire", 0.5])
	for i in 5:
		wave_data.append(["Templar", 3])
	for i in 12:
		wave_data.append(["Knight", 2])
	
## Wave 6 ##
	for i in 10:
		wave_data.append(["Knight", 1])
	for i in 1:
		wave_data.append(["Knight", 3])
	for i in 4:
		wave_data.append(["Templar", 2])
	for i in 1:
		wave_data.append(["Sentinel", 2])
	for i in 4:
		wave_data.append(["Templar", 2])

## Wave 7 ##
	for i in 10:
		wave_data.append(["Templar", 1])
	for i in 20:
		wave_data.append(["Knight", 0.5])
	for i in 8:
		wave_data.append(["Templar", 1])
	for i in 3:
		wave_data.append(["Sentinel", 2])
	for i in 8:
		wave_data.append(["Templar", 1])

## WAVE 8 ##
	for i in 3:
		wave_data.append(["Spartan", 3])
	for i in 25:
		wave_data.append(["Knight", 0.3])
	for i in 15:
		wave_data.append(["Templar", 0.5])
	for i in 5:
		wave_data.append(["Sentinel", 1])
	for i in 1:
		wave_data.append(["Sentinel", 8])
	
	
	for i in 10:
		wave_data.append(["Spartan", 2])
	for i in 10:
		wave_data.append(["Sentinel", 1])
	for i in 15:
		wave_data.append(["Spartan", 1])
	for i in 5:
		wave_data.append(["Plagued", 2])
	
	for i in 15:
		wave_data.append(["Plagued", 1])
	for i in 10:
		wave_data.append(["Sentinel", 1])
	for i in 1:
		wave_data.append(["Sentinel", 10])
	for i in 1:
		wave_data.append(["Executioner", 1])
	
	
	for i in 15:
		wave_data.append(["Plagued", 0.5])
	for i in 1:
		wave_data.append(["Executioner", 1])
	for i in 1:
		wave_data.append(["Pestilence", 1])
	for i in 1:
		wave_data.append(["Executioner", 1])
	
	
	


	var enemiesonpath = get_tree().get_nodes_in_group("path1")
	enemiesonpath[-1].get_child_count()
		
	enemies_in_wave = enemiesonpath[-1].get_child_count()
	return wave_data

func spawn_enemies(wave_data):
		for i in wave_data:
			if gamehappening == true:
				var rng = randi_range(0, 2)
				var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instantiate()
				new_enemy.connect("base_damage", on_base_damage)
				if rng == 1:
					map_node.get_node("Path2").add_child(new_enemy, true)
				else:
					map_node.get_node("Path1").add_child(new_enemy, true)
				await (get_tree().create_timer(i[1])).timeout #Creates a timer with the second index of the array inside of the wave data array

#
## Tower Building Functions
#

func initiate_build_mode(tower_type):
	if build_mode:
		return
	build_type = tower_type + "T1"
	if GameData.current_money >= GameData.tower_data[build_type]["price"] and GameData.tower_count < GameData.max_tower_count:
		build_mode = true
		get_node("UI").set_tower_preview(build_type, get_global_mouse_position())
		#add elif condition, make text flash to make it clear u dont have enough money/have max towers
	else: 
		$UI/HUD/NoBuildmodeText.visible = true
		await get_tree().create_timer(1).timeout
		$UI/HUD/NoBuildmodeText.visible = false

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cell_source_id(0, current_tile):
		get_node("UI").update_tower_preview(tile_position, "15ff00b8")
		build_valid = true 
		build_location = tile_position
		build_tile = current_tile
		
	if map_node.get_node("TowerExclusion").get_cell_source_id(0, current_tile) == -1:
		for t in get_node("Map1/Units").get_children():
			if t.position == tile_position:
				get_node("UI").update_tower_preview(tile_position, "adff4545")
				build_valid = false
				return
	
	else:
		get_node("UI").update_tower_preview(tile_position, "ff00009f")
		build_valid = false

func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").queue_free()

func verify_and_build():
	if build_valid:
		var new_tower = load("res://Scenes/Units/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		new_tower.category = GameData.tower_data[build_type]["category"]
		GameData.current_money -= GameData.tower_data[build_type]["price"]
		money_display.text = str(GameData.current_money)
		map_node.get_node("Units").add_child(new_tower, true)
		GameData.tower_count += 1
		Sfx.placetowersound()


func on_base_damage(dmg):
	base_health -= dmg
	base_healthdisplay.text = str(base_health)
	if base_health <= 0:
		Transition.change_scene("res://Scenes/UIScenes/defeat_screen.tscn")
		gamehappening = false
	get_node("UI").update_health_bar(base_health)
		

