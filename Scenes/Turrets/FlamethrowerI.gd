extends "res://Scenes/Turrets/Turrets.gd"

@onready var impact_area = get_node("Turret/Muzzle")
var flame = preload("res://Scenes/SupportScenes/Flame.tscn")

func fire():
	ready_to_fire = false
	if not get_node_or_null("Turret/Muzzle/AnimatedSprite2D"):
		ignite()
	enemy.on_hit(GameData.tower_data[type]["damage"], type)
	await(get_tree().create_timer(GameData.tower_data[type]["rof"])).timeout
	ready_to_fire = true

func ignite():
	if not $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.play()
	var new_flame = flame.instantiate()
	new_flame.name = "AnimatedSprite2D"
	impact_area.add_child(new_flame)
	

func _on_range_body_exited(body):
	enemy_array.erase(body.get_parent())
	if enemy_array.size()==0 and $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stop()	


