extends Node2D

func start(pos):
	self.global_position = pos
	get_node("Explosion").play("Boom")
	print("BOOM")

func _on_explosion_animation_finished():
	queue_free()
