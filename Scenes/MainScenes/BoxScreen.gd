extends Control

@onready var gun = get_node("TextureRect")
var gun_count = 0
var guns = ["Missile", "Mortar", "CrossBow", "FlameThrower", "TeslaCoil"]
var state = "start"
var box_pressed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	gun.visible = false
	for i in guns:
		if GameData.tower_data[i]["unlocked"] == true:
			print("removed" + str(i))
			guns.erase(i)
	print(str(guns))

func _process(delta):
	pass


func _on_box_pressed():
	if box_pressed == false:
		gun.visible = true
		get_node("Done").start()
		box_pressed = true



func _on_changer_timeout():
	if gun_count == guns.size():
		gun_count = 0
	gun.texture = load("res://Assets/Towers/" + guns[gun_count] + ".png")
	gun_count += 1


func _on_done_timeout():
	get_node("Done").stop()
	if state == "start":
		state = "spinning"
		randomize()
		var unlocked_gun = guns[randi_range(0, (guns.size() - 1))]
		get_node("Changer").stop()
		gun.texture = load("res://Assets/Towers/" + unlocked_gun + ".png")
		var gun_unlocked = get_node("/root/GameData")
		print(str(gun_unlocked.tower_data[unlocked_gun]["unlocked"]))
		gun_unlocked.tower_data[unlocked_gun]["unlocked"] = true
		print(str(gun_unlocked.tower_data[unlocked_gun]["unlocked"]))
		print(str(unlocked_gun) + " is unlocked")
		get_node("Done").start()
	elif state == "spinning":
		state = "done"
		print("Timer Done!")
		get_parent().get_node("HUD/B/ItemList").get_guns()
		get_parent().get_node("HUD").visible = true
		get_tree().paused = false
		queue_free()
