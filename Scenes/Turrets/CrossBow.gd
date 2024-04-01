extends "res://Scenes/Turrets/Turrets.gd"



func _on_animation_finished():
	get_node("Turret1").set_frame(0)
