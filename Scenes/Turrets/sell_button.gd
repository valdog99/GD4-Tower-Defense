extends TextureButton

func _ready():
	get_node("AnimationPlayer").play("Float")
# Called when the node enters the scene tree for the first tim
func _on_pressed():
	get_parent().on_sell_pressed()
