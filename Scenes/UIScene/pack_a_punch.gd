extends Control

@onready var animation = get_node("AnimationPlayer")
@onready var old_gun = get_node("Current")
@onready var new_gun = get_node("Packed")
@onready var UI = get_parent().get_parent().get_parent().get_parent().get_node("UI")

var gun_name
var packed_gun_name
var gun_type
var upgrade_name
var stats = ["name", "damage", "category", "range", "rof", ]
var gun_types = ["OldGun", "NewGun"]

func _ready():
	self.global_position.y = 0
	self.global_position.x = 0
	show_stats(get_parent().name.rstrip("0123456789"))

func get_stat(stat, gun_type):
	if stat != "name":
		if stat == "damage" or stat == "category":
			get_node("B/HBox/" + gun_type + "/Statsdel/Stats1/" + stat + "/" + gun_type).text = str(GameData.tower_data[packed_gun_name][stat])
		else:
			get_node("B/HBox/" + gun_type + "/Statsdel/Stats2/" + stat + "/" + gun_type).text = str(GameData.tower_data[packed_gun_name][stat])
	elif stat == "name":
		get_node("B/HBox/" + gun_type + "/GunName").text = packed_gun_name
		

func show_stats(selected):
	gun_name = selected
	packed_gun_name = gun_name
	for i in gun_types:
		gun_type = i
		if i != "OldGun":
			packed_gun_name += "I"
		for s in stats:
			get_stat(s, gun_type)
	animation.play("Upgrade")
	
#endregion
#region Show Old/New gun stats
	old_gun.texture = load("res://Assets/Towers/" + selected + ".png")
	new_gun.texture = load("res://Assets/Towers/" + selected + "Packed.png")
	old_gun.visible = true
	new_gun.visible = true
	#get_node("PackAPunch/GunsB/Guns/Stats/UIButtons").visible = true
	#get_node("PackAPunch/GunsB/Guns/Stats").visible = true
#endregion


func _on_verify_pressed():
	var gun_pos = get_parent().global_position
	var new_tower = load("res://Scenes/Turrets/" + packed_gun_name + ".tscn").instantiate()
	new_tower.position = gun_pos
	new_tower.built = true
	new_tower.type = packed_gun_name
	new_tower.category = GameData.tower_data[packed_gun_name]["category"]
	
	get_parent().get_parent().add_child(new_tower, true)
	get_parent().get_node("InfoScreen").visible = true
	get_parent().queue_free()
	UI.visible = true
	UI.showing_stats = false

func _on_back_pressed():
	get_parent().get_node("InfoScreen").visible = true
	queue_free() # Replace with function body.
