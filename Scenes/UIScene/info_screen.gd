extends Control

var tower_name
var pack_screen
var stats = ["damage", "category", "range", "rof", ]
@onready var UI = get_parent().get_parent().get_parent().get_parent().get_node("UI")
@onready var showing = UI.showing_stats
# Called when the node enters the scene tree for the first time.
func _ready():
	global_position.y = 0
	global_position.x = 0
	pack_screen = preload("res://Scenes/UIScene/pack_a_punch.tscn")
	show_stats(get_parent().name.rstrip("0123456789"))
	get_node("AnimationPlayer").play("Float")
	# Replace with function body.

func show_stats(selected):
	tower_name = selected
	get_node("B/HBox/OldGun/GunName").text = str(selected)
	get_node("B/HBox/SellTower/Cost").text = str(GameData.tower_data[tower_name]["cost"] / 2)
	for s in stats:
			get_stat(s)

func get_stat(stat):
	stat = str(stat)
	
	if stat == "damage" or stat == "category":
		get_node("B/HBox/OldGun/Statsdel/Stats1/" + stat + "/OldGun").text = str(GameData.tower_data[tower_name][stat])
	else:
		get_node("B/HBox/OldGun/Statsdel/Stats2/" + stat + "/OldGun").text = str(GameData.tower_data[tower_name][stat])
	
		
	


func _on_pack_a_pucnch_pressed():
	visible = false
	var pack_screen_instance = pack_screen.instantiate()
	get_parent().add_child(pack_screen_instance) 
	 # Replace with function body.


func on_sell_button_pressed():
	UI.gain_cash(GameData.tower_data[tower_name]["cost"] / 2) 
	get_parent().queue_free()
	UI.visible = true
	UI.showing_stats = false
	
	
