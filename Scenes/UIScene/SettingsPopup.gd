extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_resume_pressed():
	get_tree().paused = false
	get_parent().reset_process_mode()
	queue_free()
	if get_parent().paused:
		get_tree().paused = true


func _on_restart_pressed():
	get_tree().paused = false
	get_parent().get_parent().queue_free()
	get_parent().get_parent().get_parent().load_level(get_parent().get_parent().level)


func _on_settings_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().paused = false
	get_parent().get_parent().queue_free()
	get_parent().get_parent().get_parent().load_main_menu()
