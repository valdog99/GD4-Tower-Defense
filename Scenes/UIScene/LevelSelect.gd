extends Control

var level 
var num_Levels = 2

func _ready():
	level = 1
	
	
func _on_play_pressed():
	get_parent().on_play_level_pressed()


func _on_select_right_pressed():
	if(level == num_Levels):
		level = 1
	else:
		level += 1
	get_node("B/MapImage").texture = load("res://Assets/Maps/map" + str(level) + ".png")
	get_node("B/LevelNumber").text = str(level)
	


func _on_select_left_pressed():
	if(level == 1):
		level = num_Levels
	else:
		level -= 1
	get_node("B/MapImage").texture = load("res://Assets/Maps/map" + str(level) + ".png")
	get_node("B/LevelNumber").text = str(level)
	


func _on_back_pressed():
	queue_free()
	get_parent().load_gamemode_select_scene()
