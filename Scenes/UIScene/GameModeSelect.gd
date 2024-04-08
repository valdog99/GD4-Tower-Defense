extends Control

@onready var back_button = get_node("Back")

func ready():
	back_button.set_as_top_level(true)

func _on_campaign_pressed():
	get_parent().on_campaign_pressed()


func _on_endless_pressed():
	get_parent().on_endless_pressed()


func _on_challenge_pressed():
	get_parent().on_challenge_pressed()


func _on_back_pressed():
	queue_free()
	get_parent().load_main_menu()
