extends "res://Scenes/Turrets/Turrets.gd"

func fire():
	ready_to_fire = false
	get_node("AnimationPlayer").play("Fire")
	$AudioStreamPlayer.play()
	enemy.on_hit(GameData.tower_data[type]["damage"], type)
	await(get_tree().create_timer(GameData.tower_data[type]["rof"])).timeout
	ready_to_fire = true

