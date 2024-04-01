extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("B/M/VB/Resume").pressed.connect(on_resume_pressed) # Replace with function body.
	get_node("B/M/VB/Quit").pressed.connect(on_quit_pressed)

func on_resume_pressed():
	get_node("PauseButton").show()
	get_node("GameScene").show()
	get_node("PauseMenu").queue_free()
	
func on_quit_pressed():
	get_tree().quit()

