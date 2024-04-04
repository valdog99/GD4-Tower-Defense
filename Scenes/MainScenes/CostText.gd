extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	if not visible:
		get_node("Cost").text = str(GameData.tower_data[get_parent().name]["cost"])
		visible = true # Replace with function body.


func _on_mouse_exited():
	if visible:
		visible = false # Replace with function body.


