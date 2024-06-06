extends Control

@onready var outlaw_lore = $TabContainer/Towers/OutlawLore
@onready var marksman_lore = $TabContainer/Towers/MarksmanLore
@onready var gunner_lore = $TabContainer/Towers/GunnerLore
@onready var demoman_lore = $TabContainer/Towers/DemomanLore
@onready var squire_lore = $TabContainer/Attackers/Squire
@onready var knight_lore = $TabContainer/Attackers/KnightLore
@onready var templar_lore = $TabContainer/Attackers/TemplarLore
@onready var sentinel_lore = $TabContainer/Attackers/SentinelLore
@onready var spartan_lore = $TabContainer/Attackers/SpartanLore
@onready var plagued_lore = $TabContainer/Attackers/PlaguedLore
@onready var executioner_lore = $TabContainer/Attackers/ExecutionerLore
@onready var pestilence_lore = $TabContainer/Attackers/PestilenceLore



func _ready():
	#tower lore nodes
	get_node("TabContainer/Towers/MC/VB/Button").pressed.connect(on_outlaw_pressed)
	get_node("TabContainer/Towers/MC2/VB/Button").pressed.connect(on_marksman_pressed)
	get_node("TabContainer/Towers/MC3/VB/Button").pressed.connect(on_gunner_pressed)
	get_node("TabContainer/Towers/MC4/VB/Button").pressed.connect(on_demoman_pressed)
	
	#attacker lore nodes
	get_node("TabContainer/Attackers/MC/VB/HB/TB").pressed.connect(on_squire_pressed)
	get_node("TabContainer/Attackers/MC/VB/HB/TB2").pressed.connect(on_knight_pressed)
	get_node("TabContainer/Attackers/MC/VB/HB/TB3").pressed.connect(on_templar_pressed)
	get_node("TabContainer/Attackers/MC/VB/HB/TB4").pressed.connect(on_sentinel_pressed)
	get_node("TabContainer/Attackers/MC/VB/HB2/TB").pressed.connect(on_spartan_pressed)
	get_node("TabContainer/Attackers/MC/VB/HB2/TB2").pressed.connect(on_plagued_pressed)
	get_node("TabContainer/Attackers/MC/VB/HB2/TB3").pressed.connect(on_exec_pressed)
	get_node("TabContainer/Attackers/MC/VB/HB2/TB4").pressed.connect(on_pestilence_pressed)

func on_outlaw_pressed():
	Sfx.clicksfx()
	outlaw_lore.visible = true

func on_marksman_pressed():
	Sfx.clicksfx()
	marksman_lore.visible = true

func on_gunner_pressed():
	Sfx.clicksfx()
	gunner_lore.visible = true

func on_demoman_pressed():
	Sfx.clicksfx()
	demoman_lore.visible = true




func on_squire_pressed():
	Sfx.clicksfx()
	squire_lore.visible = true

func on_knight_pressed():
	Sfx.clicksfx()
	knight_lore.visible = true

func on_templar_pressed():
	Sfx.clicksfx()
	templar_lore.visible = true
	
func on_sentinel_pressed():
	Sfx.clicksfx()
	sentinel_lore.visible = true

func on_spartan_pressed():
	Sfx.clicksfx()
	spartan_lore.visible = true

func on_plagued_pressed():
	Sfx.clicksfx()
	plagued_lore.visible = true

func on_exec_pressed():
	Sfx.clicksfx()
	executioner_lore.visible = true

func on_pestilence_pressed():
	Sfx.clicksfx()
	pestilence_lore.visible = true



