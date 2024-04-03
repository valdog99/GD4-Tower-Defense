extends CanvasLayer

@onready var upgrade_options = get_tree().get_nodes_in_group("pack_buttons")
@onready var animation = get_node("PackAPunch/AnimationPlayer")
@onready var old_gun = get_node("PackAPunch/Current")
@onready var new_gun = get_node("PackAPunch/Packed")

var gun_name

func _ready():
	self.visible = false
	hide_stats()
	show_guns()

func _on_cross_bow_pressed():
	show_stats("CrossBow")

func _on_gun_pressed():
	show_stats("Gun")

func show_stats(selected):
	for i in upgrade_options:
		i.visible = false
	gun_name = selected
	
#region Setting New/Old Gun Vlaues1
	get_node("PackAPunch/GunsB/Guns/Stats/NewStats/Damage").text = str(GameData.tower_data[selected + str("Packed")]["damage"])
	get_node("PackAPunch/GunsB/Guns/Stats/NewStats/ROF").text = str(GameData.tower_data[selected + str("Packed")]["rof"] * -1 + 2)
	get_node("PackAPunch/GunsB/Guns/Stats/NewStats/Range").text = str(GameData.tower_data[selected + str("Packed")]["range"])
	get_node("PackAPunch/GunsB/Guns/Stats/NewStats/Cost").text = str(GameData.tower_data[selected + str("Packed")]["cost"])
	get_node("PackAPunch/GunsB/Guns/Stats/OldStats/Damage").text = str(GameData.tower_data[selected]["damage"])
	get_node("PackAPunch/GunsB/Guns/Stats/OldStats/ROF").text = str(GameData.tower_data[selected]["rof"] * -1 + 2)
	get_node("PackAPunch/GunsB/Guns/Stats/OldStats/Range").text = str(GameData.tower_data[selected]["range"])
	get_node("PackAPunch/GunsB/Guns/Stats/OldStats/Cost").text = str(GameData.tower_data[selected]["cost"])
#endregion
#region Show Old/New gun stats
	old_gun.texture = load("res://Assets/Towers/" + selected + ".png")
	new_gun.texture = load("res://Assets/Towers/" + selected + "Packed.png")
	old_gun.visible = true
	new_gun.visible = true
	get_node("PackAPunch/GunsB/Guns/Stats/UIButtons/BackVerify").visible = true
	get_node("PackAPunch/GunsB/Guns/Stats").visible = true
#endregion
	animation.play("upgrade_guns")
	
func hide_stats():
	old_gun.visible = false
	new_gun.visible = false
	get_node("PackAPunch/GunsB/Guns/Stats/UIButtons/BackVerify").visible = false
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
	UI._on_pause_play_pressed()
	UI.get_node("HUD/BuildBar/" + gun_name).visible = false
	UI.get_node("HUD/BuildBar/" + gun_name + "Packed").visible = true
	
	
