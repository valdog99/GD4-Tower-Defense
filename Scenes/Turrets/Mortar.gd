extends "res://Scenes/Turrets/Turrets.gd"

var mortar_projectile = preload("res://Scenes/SupportScenes/MortarProjectile.tscn")
var enemies_in_blast = []
var enemy_pos

	
func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.progress)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	if enemy_array.size()>1:
		enemy = enemy_array[enemy_array.size()/2]
	else:
		enemy = enemy_array[enemy_index]

func fire():
	ready_to_fire = false
	$MortarLaunchSound.play()
	var mortar_projectile_instance = mortar_projectile.instantiate()
	add_child(mortar_projectile_instance)
	enemy_pos = $MortarProjectile.enemy_pos
	get_node("AnimationPlayer").play("Flash")
	await(get_tree().create_timer(GameData.tower_data[type]["rof"])).timeout
	ready_to_fire = true
	
func explode():
	$MortarImpactSound.play()
	for i in enemies_in_blast:
		i.on_hit(GameData.tower_data[type]["damage"], type)
	$AnimatedSprite2D.set_global_position(enemy_pos)
	get_node("AnimationPlayer").queue("Explode")
	get_node("MortarProjectile").queue_free()
