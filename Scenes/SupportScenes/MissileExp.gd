extends PathFollow2D


# Called when the node enters the scene tree for the first time.
func start(enemy):
	progress = enemy 
	get_node("Explosion").play("Boom")

	
	
func _on_explosion_animation_finished():
	queue_free()
