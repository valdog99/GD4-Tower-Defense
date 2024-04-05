extends Node2D

signal BaseDamaged(damage)

var enemy_array = []
var dps
func _ready():
	get_node("Damage").autostart = true
	get_node("Damage").start

func _physics_process(delta):
	return

func _on_area_2d_body_entered(body):
	dps = 0
	enemy_array.append(body.get_parent())
	for i in enemy_array:
		dps += GameData.enemy_data[i.name.rstrip("0123456789")]["damage"]
	emit_signal("BaseDamaged", dps)
	get_node("AnimationPlayer").play("Hit2")
	await get_tree().create_timer(1).timeout


func _on_damage_timeout():
	if enemy_array.size() != 0 :
		emit_signal("BaseDamaged", dps)
		for i in enemy_array:
			i.on_hit(5, "Arrow")
			





func _on_area_2d_body_exited(body):
	enemy_array.erase(body.get_parent())
	get_node("AnimationPlayer").stop()
	
	
