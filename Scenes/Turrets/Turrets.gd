extends Node2D

var enemy_array = []
var built = false
var enemy
var type
var ready_to_fire = true
var category
var missile_num = 0
@onready var UI = get_parent().get_parent().get_parent().get_node("UI")
var inspect_button = preload("res://Scenes/Turrets/inspect.tscn")
var missile_launch = preload("res://Scenes/Turrets/MissileHit.tscn")
var info_screen = preload("res://Scenes/UIScene/info_screen.tscn")

func _ready():
	if built:
		var inspect_button_instance = inspect_button.instantiate()
		add_child(inspect_button_instance)
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[type]["range"]

func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		if not get_node("AnimationPlayer").is_playing() or GameData.tower_data[type]["category"] == "Bullet" or "Arrow" or "Zap":
			turn()
		if ready_to_fire:
			fire()
	else:
		enemy = null

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and get_node_or_null("InfoScreen"):
		delete_sell()

func on_inspect_pressed():
	get_parent().get_parent().get_parent().get_node("UI").visible = false
	#var sell_button_instance = sell_button.instantiate()
	var info_screen_instance = info_screen.instantiate()
	if not UI.showing_stats:
		add_child(info_screen_instance, true)
		UI.showing_stats = true

	#add_child(sell_button_instance)

func sell_tower():
	UI.visible = true
	UI.gain_cash(GameData.tower_data[type]["cost"] / 2) 
	queue_free()

func delete_sell():
	if get_node_or_null("PackAPunch"):
		get_node("PackAPunch").free()
		get_node("InfoScreen").visible = true
	else:
		get_node("InfoScreen").queue_free()
		get_parent().get_parent().get_parent().get_node("UI").visible = true

func turn():
	get_node("Turret").look_at(enemy.position)

func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		if i != null:
			enemy_progress_array.append(i.progress) ## Progress is how may pixels enemy has travelled
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]

func fire():
	enemy.on_hit(GameData.tower_data[type]["damage"], GameData.tower_data[type]["category"])
	ready_to_fire = false
	if category == "Bullet":
		fire_gun()
	elif category == "Missile":
		fire_missile()
	elif category == "Arrow":
		fire_arrow()
	elif category == "Zap":
		zap()
	
	await get_tree().create_timer(GameData.tower_data[type]["rof"]).timeout
	ready_to_fire = true

func fire_gun():
	get_node("AnimationPlayer").play("Fire")

func fire_missile():
	if missile_num == 0:
		get_node("AnimationPlayer").play("Reload_1")
		add_child(missile_launch.instantiate())
		missile_num += 1
	elif missile_num == 1:
		get_node("AnimationPlayer").play("Reload_2")
		add_child(missile_launch.instantiate())
		missile_num -= 1
	else:
		missile_num = 0

func fire_arrow():
	get_node("Turret").play("Fire")

func zap():
	get_node("Turret").visible = true
	var distance = get_node("Distance")
	distance.clear_points()
	distance.add_point(get_node("Turret").position)
	distance.add_point(Vector2(enemy.global_position.x - get_node("Turret").global_position.x,  enemy.global_position.y - get_node("Turret").global_position.y))
	get_node("AnimationPlayer").play("Fire")

func _on_range_body_entered(body):
	enemy_array.append(body.get_parent())

func _on_range_body_exited(body):
	enemy_array.erase(body.get_parent())
	if category == "Zap":
		get_node("Turret").visible = false

