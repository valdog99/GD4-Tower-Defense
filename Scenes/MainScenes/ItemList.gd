extends ItemList

var guns = ["CrossBow", "Missile", "TeslaCoil", "Gun", "FlameThrower", "Mortar"]
var gun_names = ["Cross\nBow", "Missile", "Tesla\nCoil", "Gun", "Flame\nThrower", "Mortar"]
# Called when the node enters the scene tree for the first time.
func _ready():
	get_guns()

 # Replace with function body.
func get_guns():
	set_item_count(0)
	for i in guns:
		var gun_name
		var gun = i
		if GameData.tower_data[gun]["unlocked"] == true:
			if i == "CrossBow":
				gun_name = "Cross\nBow"
			elif i == "TeslaCoil":
				gun_name = "Tesla\nCoil"
			elif i == "FlameThrower":
				gun_name = "Flame\nThrower"
			
			else:
				gun_name = gun
			var index = add_item("$ " + str(GameData.tower_data[gun]["cost"]) + "\n" + gun_name)
			set_item_icon(index, load("res://Assets/Towers/" + gun + "CH.png"))
