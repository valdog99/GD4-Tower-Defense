extends CanvasLayer

@onready var upgrade_options = get_tree().get_nodes_in_group("pack_buttons")
@onready var animation = get_node("PackAPunch/AnimationPlayer")
@onready var old_gun = get_node("PackAPunch/Current")
@onready var new_gun = get_node("PackAPunch/Packed")

var gun_name
var packed_gun_name
var gun_type
var upgrade_name
var stats = ["name", "damage", "cost", "range", "rof", ]
var gun_types = ["OldGun", "NewGun"]

func _ready():
	self.visible = false
	hide_stats()
	show_guns()

func _on_cross_bow_pressed():
	show_stats("CrossBow")

func _on_gun_pressed():
	show_stats("Gun")

func get_stat(stat, gun_type):
	if stat != "name":
		get_node("PackAPunch/GunsB/Guns/Stats/Stats/" + stat + "/" + gun_type).text = str(GameData.tower_data[packed_gun_name][stat])
	elif stat == "name":
		get_node("PackAPunch/GunsB/Guns/Stats/Stats/GunNames/" + gun_type).text = packed_gun_name

		

func show_stats(selected):
	for i in upgrade_options:
		i.visible = false
	gun_name = selected
	packed_gun_name = selected
	get_node("PackAPunch/GunsB/Guns/Stats/UIButtons/pack_cost/Cost").text = str(GameData.tower_data[selected]["pack_cost"])
	get_node("PackAPunch/GunsB/Guns/Stats/Stats/GunNames/OldGun").text = selected
	get_node("PackAPunch/GunsB/Guns/Stats/Stats/GunNames/OldGun").text = selected + "Packed"
	
	for i in gun_types:
		gun_type = i
		if i != "OldGun":
			packed_gun_name += "Packed"
		for s in stats:
			get_stat(s, gun_type)
	

	
	

#endregion
#region Show Old/New gun stats
	old_gun.texture = load("res://Assets/Towers/" + selected + ".png")
	new_gun.texture = load("res://Assets/Towers/" + selected + "Packed.png")
	old_gun.visible = true
	new_gun.visible = true
	get_node("PackAPunch/GunsB/Guns/Stats/UIButtons").visible = true
	get_node("PackAPunch/GunsB/Guns/Stats").visible = true
#endregion
	animation.play("upgrade_guns")
	
func hide_stats():
	old_gun.visible = false
	gun_type = ""
	new_gun.visible = false
	get_node("PackAPunch/GunsB/Guns/Stats/UIButtons").visible = false
	get_node("PackAPunch/GunsB/Guns/Stats").visible = false
	
func show_guns():
	for i in upgrade_options:
		i.visible = true

func _on_exit_pressed():
	hide_stats()
	show_guns()
	var UI = get_parent()
	UI.get_node("HUD").visible = true	
	UI.get_node("PackScreen").visible = false
	UI._on_pause_play_pressed()
	 # Replace with function body.

func _on_back_pressed():
	hide_stats()
	show_guns()

func _on_verfy_pressed():
	hide_stats()
	show_guns()
	var UI = get_parent()
	UI.get_node("HUD").visible = true	
	UI.get_node("PackScreen").visible = false
	UI.loose_cash(GameData.tower_data[gun_name]["pack_cost"])
	UI._on_pause_play_pressed()
	UI.get_node("HUD/BuildBar/" + gun_name).visible = false
	UI.get_node("HUD/BuildBar/" + gun_name + "Packed").visible = true
	
	
