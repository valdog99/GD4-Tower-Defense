extends PathFollow2D

signal base_damage(damage)
signal death(cash)

@onready var type = self.name.rstrip('0123456789')
@onready var health_bar = get_node("HealthBar")
@onready var impact_area = get_node("Impact")

@onready var speed = GameData.enemy_data[type]["speed"]
@onready var hp = GameData.enemy_data[type]["health"]
@onready var damage = GameData.enemy_data[type]["damage"]
@onready var zap_impact = preload("res://Scenes/SupportScenes/ZapImpact.tscn")
@onready var missile_impact = preload("res://Scenes/SupportScenes/MissileImpact.tscn")
@onready var arrow_impact = preload("res://Scenes/SupportScenes/ArrowImpact.tscn")



func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.top_level = true

func _physics_process(delta):
	if progress_ratio == 1.0:
		emit_signal("base_damage", damage)
		queue_free()
	move(delta)
	
func move(delta):
	set_progress(get_progress() + speed * delta)
	health_bar.set_position(position - Vector2(30, 30))
	
func on_hit(damage, type):
	impact(type)
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
	

func impact(type):
	## Forces the x & y value of -15 to 15
	randomize() # Randomizes Scene
	var x_pos_neg = (randi() % 16) * -1
	randomize()
	var x_pos_pos = randi() % 16
	var x_pos = (x_pos_neg + x_pos_pos)
	randomize()
	var y_pos_neg = (randi() % 16) * -1
	randomize()
	var y_pos_pos = randi() % 16
	var y_pos = (y_pos_neg + y_pos_pos)
	
	var impact_location = Vector2(x_pos, y_pos)
	if type == "Zap":
		var new_impact = zap_impact.instantiate()
		new_impact.position = impact_location
		impact_area.add_child(new_impact)
	else:
		var new_impact = arrow_impact.instantiate()
		new_impact.position = impact_location
		impact_area.add_child(new_impact)


func on_destroy():
	emit_signal("death", GameData.enemy_data[type]["value"])
	get_node("CharacterBody2D").queue_free()
	await get_tree().create_timer(0.2).timeout
	self.queue_free()
