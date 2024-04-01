extends AnimatedSprite2D

func on_start():
	self.set_frame(0)
	
func start():
	self.play("Fire")
	
func _on_animation_finished():
	self.set_frame(0) # Replace with function body.
