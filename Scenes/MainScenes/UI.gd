extends CanvasLayer

@onready var hp_bar = get_node("HUD/H/InfoBar/HealthNum")
#@onready var tween = create_tween()
@onready var cash_counter = get_node("HUD/H/InfoBar/Bal")
@onready var wave_counter = get_node("HUD/H/InfoBar/HBox/WaveCounter")




func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://Scenes/Turrets/" + tower_type + ".tscn").instantiate()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ad54ff3c")	

#	shows player range of guns
	var range_texture = Sprite2D.new()
#	range_texture.position = Vector2(32,32)
	var scaling = GameData.tower_data[tower_type]["range"] / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://UI/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("ad54ff3c")

	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0)

func update_tower_preview(new_position, color):
	get_node("TowerPreview").position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/Sprite2D").modulate = Color(color)

##
## Game Control Functions
##

func _on_pause_play_pressed():
	# Cancels Build Mode When Paused
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	# Pause/Play functionality
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().current_wave == 0:
		get_parent().current_wave +=1
		get_parent().start_next_wave()
	else:
		get_tree().paused = true
		

func _on_speed_up_pressed():
	# Cancels Build Mode When Paused
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	# Fast Forward functionality
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)

func update_health_bar(base_health):
	#var hp_bar_tween = tween.bind_node(hp_bar)
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.set_trans(Tween.TRANS_LINEAR)
	#tween.tween_property(hp_bar, "value", base_health, 0.1)
	var home_icon = get_node("HUD/H/InfoBar/HomeIcon")
	hp_bar.text = str(base_health)
	if int(hp_bar.text) >= 60:
		hp_bar.label_settings.font_color = Color("005a00")
		hp_bar.label_settings.outline_color = Color("44b673")
		hp_bar.label_settings.shadow_color = Color("64ff0038")
		home_icon.modulate = Color("44b673")
	elif int(hp_bar.text) <= 60 and int(hp_bar.text) >= 25:
		hp_bar.label_settings.font_color = Color("705703")
		hp_bar.label_settings.outline_color = Color("bb9902")
		hp_bar.label_settings.shadow_color = Color("64600098")
		home_icon.modulate = Color("bb9902")
	else:
		hp_bar.label_settings.font_color = Color("57060f")
		hp_bar.label_settings.outline_color = Color("f30000")
		hp_bar.label_settings.shadow_color = Color("62000098")
		home_icon.modulate = Color("f30000")
		
func verify_cost(tower_type): 
	if int(cash_counter.text) >= 0:
		debt(tower_type)
		return true
		 
	else:
		return false
		

func ghost_debt(tower_type):
	cash_counter.modulate =  Color("f30006")
	get_node("HUD/H/InfoBar/DollaSign").modulate = Color("f30006")
	var cost = GameData.tower_data[tower_type]["cost"] 
	var current_cash_int = int(cash_counter.text) 
	current_cash_int -= cost
	cash_counter.text = str(current_cash_int)
	

func debt(tower_type):
	cash_counter.modulate =  Color("ffffff")
	get_node("HUD/H/InfoBar/DollaSign").modulate = Color("ffffff")
	var cost = GameData.tower_data[tower_type]["cost"] 
	var current_cash_int = int(cash_counter.text) 
	current_cash_int -= cost
	cash_counter.text = str(current_cash_int)


func refund(tower_type):
	cash_counter.modulate =  Color("ffffff")
	get_node("HUD/H/InfoBar/DollaSign").modulate = Color("ffffff")
	gain_cash(GameData.tower_data[tower_type]["cost"])

func _on_pack_a_pucnch_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	# Pause/Play functionality
	if get_parent().current_wave == 0:
		print("Get To Wave 5 to use...")#pop up tuttorial text
	else:
		get_node("HUD").visible = false	
		get_node("PackScreen").visible = true
		get_tree().paused = true
		
	# Replace with function body.

func update_wave_counter(wave):
	var tally = load("res://Assets/UI/WaveTally" + str(wave) + ".png")
	wave_counter.texture = tally

func gain_cash(cash):
	cash_counter.text = str(int(cash_counter.text) + cash)

func loose_cash(cash):
	cash_counter.text = str(int(cash_counter.text) - cash)
	
	
	
