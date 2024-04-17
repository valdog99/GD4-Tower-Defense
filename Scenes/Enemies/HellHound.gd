extends "res://Scenes/Enemies/Enemies.gd"

func _ready():
	$Sprite2D.play("default")
func on_hit(damage, type):
	var rand = (randi() % 5)
	if(rand==4):
		$Screech.play()
	impact(type)
	hp -= damage
	health_bar.value = hp
	if hp<=0:
		on_destroy()
