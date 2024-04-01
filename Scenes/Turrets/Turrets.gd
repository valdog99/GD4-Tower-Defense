extends Node2D

var enemy_array = []
var built = false
var enemy
var type
var ready_to_fire = true
var category
var missile_num = 0

func _ready():
	if built:
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
		

func turn():
	get_node("Turret").look_at(enemy.position)
			

func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.progress) ## Progress is how may pixels enemy has travelled
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]

func fire():
	ready_to_fire = false
	if category == "Bullet":
		fire_gun()
	elif category == "Missile":
		fire_missile()
	elif category == "Arrow":
		fire_arrow()
	elif category == "Zap":
		zap()
	enemy.on_hit(GameData.tower_data[type]["damage"], GameData.tower_data[type]["category"])
	await get_tree().create_timer(GameData.tower_data[type]["rof"]).timeout
	ready_to_fire = true

func fire_gun():
	get_node("AnimationPlayer").play("Fire")

func fire_missile():
	if missile_num == 0:
		get_node("AnimationPlayer").play("Reload_1")
		missile_num += 1
	elif missile_num == 1:
		get_node("AnimationPlayer").play("Reload_2")
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

