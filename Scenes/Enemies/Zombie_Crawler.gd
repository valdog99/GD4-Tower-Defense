extends "res://Scenes/Enemies/Enemies.gd"

func _ready():
	$AnimationPlayer.play("Walk")
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.top_level = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Hit":
		$AnimationPlayer.play("Walk")

func on_hit(damage, type):
	var rand = (randi() % 5)
	if(rand==4):
		$Screech.play()
	impact(type)
	hp -= damage
	health_bar.value = hp
	if hp<=0:
		on_destroy()
