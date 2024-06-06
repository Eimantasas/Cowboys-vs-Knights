extends Control


func _ready():
	get_node("TabContainer/Tier 1/X").pressed.connect(on_x_pressed)
	get_node("TabContainer/Tier 2/X").pressed.connect(on_x_pressed)
	get_node("TabContainer/Tier 3/X").pressed.connect(on_x_pressed)
	


func on_x_pressed():
	self.visible = false
	Sfx.clicksfx()
