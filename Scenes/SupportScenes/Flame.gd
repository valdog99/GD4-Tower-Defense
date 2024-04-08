extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var frame_number = 3
	play("Flame")
	while(get_parent().get_parent().get_parent().enemy_array.size()>0 and not get_tree().is_paused() and get_parent().get_parent().get_parent().enemy != null):
		self.frame = frame_number
		await (get_tree().create_timer(0.5)).timeout
		if(frame_number==5):
			frame_number = 2
		frame_number += 1


func _on_animation_finished():
	queue_free()
