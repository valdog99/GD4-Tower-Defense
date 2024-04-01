extends "res://Scenes/Turrets/Turrets.gd"

func _on_animation_player_animation_started(anim_name):
	get_node("Coil").play("Start") # Replace with function body.
	
func _on_coil_animation_finished():
	get_node("Coil").stop()

func _on_animation_player_animation_finished(anim_name):
	get_node("Coil").play("Start")
	


