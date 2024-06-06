extends Control

func _ready():
	get_node("TabContainer/The Plagued/X").pressed.connect(on_x_pressed)
	


func on_x_pressed():
	self.visible = false
