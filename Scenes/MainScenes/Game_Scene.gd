extends Node2D

signal game_finished(result)

var map_node
var UI_node

var build_mode = false

var build_valid = false
var build_tile
var build_location
var build_type

var current_wave = 0
var enemies_in_wave = 0

var base_health = 100


func _ready():
	map_node = get_node("Map1")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	for i in range(5):
		var wave = GameData.wave_data[map_node.name]["Wave" + str(i + 1)]
		for z in range(10):
			var zom_array = ["Zombie_Normal", int(z + 4)]
			wave.append(zom_array)
			
	
	
func _process(delta):
	if build_mode:
		update_tower_preview()
	if enemies_in_wave == 0 and current_wave != 0:
		start_next_wave()
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

##
## Wave Functions
##
func start_next_wave():
	UI_node = get_node("UI")
	get_node("UI").update_wave_counter(current_wave)
	get_node("UI/HUD/RoundChange").play()
	var wave_data = retrieve_wave_data()
	await(get_tree().create_timer(4)).timeout #So waves dont start imedietly
	spawn_enemies(wave_data)
	get_node("Base").BaseDamaged.connect(on_base_damage)
func retrieve_wave_data():
	var wave_data = GameData.wave_data[map_node.name]["Wave" + str(current_wave)]
	current_wave += 1
#	if current_wave == 5:
#		for z in range(10):
#			wave_data.append(["Zombie_Normal" z])
	enemies_in_wave = wave_data.size()
	return wave_data
	
func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instantiate()
		map_node.get_node("Path2D").add_child(new_enemy, true) 
		var path_node = map_node.get_node("Path2D")
		#var enemy = path_node.get_node(i[0])
		#new_enemy.base_damage.connect(on_base_damage)
		new_enemy.death.connect(on_enemy_killed)
		await(get_tree().create_timer(i[1])).timeout

##
## Building Functions
##

	
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	for i in get_node("Map1/Turrets").get_children():
		if i.get_node_or_null("SellButton"):
			i.get_node("SellButton").queue_free()
	build_type = tower_type
	build_mode = true
	get_node("UI").ghost_debt(build_type)
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cell_tile_data(0, current_tile) == null:
		get_node("UI").update_tower_preview(tile_position, "adff4545") 
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		get_node("UI").update_tower_preview(tile_position, "ad54ff3c")
		build_valid = false

func cancel_build_mode():
	get_node("UI").refund(build_type)
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()

func verify_and_build():
	if build_valid:
		if get_node("UI").verify_cost(build_type):
		## Verify player has cash
			var new_tower = load("res://Scenes/Turrets/" + build_type + ".tscn").instantiate()
			new_tower.position = build_location
			new_tower.built = true
			new_tower.type = build_type
			new_tower.category = GameData.tower_data[build_type]["category"]
			map_node.get_node("Turrets").add_child(new_tower, true)
			map_node.get_node("TowerExclusion").set_cell(0, build_tile, 5, Vector2(0, 1))


func on_base_damage(dps):
	base_health = int(base_health - dps)
	if base_health <= 0:
		emit_signal("game_finished", false)
		enemies_in_wave = 0
	else:
		get_node("UI").update_health_bar(base_health)
	#	get_node("UI").update_health_bar(base_health)
	
func on_enemy_killed(value):
	enemies_in_wave -= 1
	UI_node.gain_cash(value)
	
