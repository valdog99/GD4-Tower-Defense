extends Node2D

signal enemy_enter(damage)

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


func _on_damage_timeout():
	if enemy_array.size() != 0 :
		emit_signal("enemy_enter", dps)




func _on_area_2d_body_exited(body):
	enemy_array.erase(body.get_parent())
