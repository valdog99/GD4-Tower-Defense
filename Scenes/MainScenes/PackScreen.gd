extends Control

@onready var animation = get_node("PackAPunch2/AnimationPlayer")
@onready var old_gun = get_node("PackAPunch2/Current")
@onready var new_gun = get_node("PackAPunch2/Packed")

var gun_name
var packed_gun_name
var gun_type
var upgrade_name
var stats = ["name", "damage", "category", "range", "rof", ]
var gun_types = ["OldGun", "NewGun"]

func _ready():
	self.global_position.y = 0
	self.global_position.x = 0
	show_stats(get_parent().name)
	



func get_stat(stat, gun_type, screen):
	if stat != "name":
		if stat == "damage" or stat == "category":
			get_node(screen + "/B/HBox/" + gun_type + "/Statsdel/Stats1/" + stat + "/" + gun_type).text = str(GameData.tower_data[packed_gun_name][stat])
		else:
			get_node(screen + "/B/HBox/" + gun_type + "/Statsdel/Stats2/" + stat + "/" + gun_type).text = str(GameData.tower_data[packed_gun_name][stat])
	elif stat == "name":
		get_node(screen + "/B/HBox/" + gun_type + "/GunName").text = packed_gun_name
		


		

func show_stats(selected):
	gun_name = selected.rstrip("0123456789")
	packed_gun_name = gun_name
	get_node("InfoScreen/B/HBox/PackAPunch/Cost").text = str(GameData.tower_data[selected]["pack_cost"])
	#get_node("InfoScreen/B/OldStats/Stats/GunName").text = selected
	#get_node("PackAPunch/GunsB/Guns/Stats/Stats/GunNames/OldGun").text = selected + "Packed"
	

	for s in stats:
		get_stat(s, "OldGun", "InfoScreen")

#endregion
#region Show Old/New gun stats
	old_gun.texture = load("res://Assets/Towers/" + selected + ".png")
	new_gun.texture = load("res://Assets/Towers/" + selected + "Packed.png")
	old_gun.visible = true
	new_gun.visible = true
	#get_node("PackAPunch/GunsB/Guns/Stats/UIButtons").visible = true
	#get_node("PackAPunch/GunsB/Guns/Stats").visible = true
#endregion
	
	
func hide_stats():
	old_gun.visible = false
	gun_type = ""
	new_gun.visible = false
	get_node("PackAPunch/GunsB/Guns/Stats/UIButtons").visible = false
	get_node("PackAPunch/GunsB/Guns/Stats").visible = false
	


func _on_exit_pressed():
	hide_stats()
	var UI = get_parent()
	UI.get_node("HUD").visible = true	
	UI.get_node("PackScreen").visible = false
	UI._on_pause_play_pressed()
	 # Replace with function body.

func _on_back_pressed():
	hide_stats()

func _on_verfy_pressed():
	hide_stats()
	var UI = get_parent()
	UI.get_node("HUD").visible = true	
	UI.get_node("PackScreen").visible = false
	UI.loose_cash(GameData.tower_data[gun_name]["pack_cost"])
	UI._on_pause_play_pressed()
	UI.get_node("HUD/BuildBar/" + gun_name).visible = false
	UI.get_node("HUD/BuildBar/" + gun_name + "Packed").visible = true
	
	


func _on_pack_a_pucnch_pressed():
	get_node("InfoScreen").visible = false
	for i in gun_types:
		gun_type = i
		if i != "OldGun":
			packed_gun_name += "Packed"
		for s in stats:
			get_stat(s, gun_type, "PackAPunch2")
	get_node("PackAPunch2").visible = true
	animation.play("Upgrade")


func _on_sell_button_pressed():
		get_parent().on_sell_pressed()# Replace with function body.
