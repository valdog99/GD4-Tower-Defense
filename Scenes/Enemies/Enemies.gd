extends PathFollow2D

signal base_damage(damage)
signal death(cash)

@onready var type = self.name.rstrip('0123456789')
@onready var health_bar = get_node("HealthBar")
#region Load Game Data
@onready var speed = GameData.enemy_data[type]["speed"]
@onready var hp = GameData.enemy_data[type]["health"]
@onready var damage = GameData.enemy_data[type]["damage"]

#endregion
#region Preload Impacts
@onready var impact_area = get_node("Impact")
@onready var zap_impact = preload("res://Scenes/SupportScenes/ZapImpact.tscn")
@onready var missile_impact = preload("res://Scenes/SupportScenes/MissileImpact.tscn")
@onready var arrow_impact = preload("res://Scenes/SupportScenes/ArrowImpact.tscn")
#endregion

var path_complete = false

func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.top_level = true

func _physics_process(delta):
	if progress_ratio == 1.0 and path_complete == false:
		set_progress(get_progress())
		path_complete = true
		base_hit()

	move(delta)

func base_hit():
	set_progress(get_progress())
	randomize()
	var rng = RandomNumberGenerator.new()
	var old_y = global_position.y
	var new_y = int(rng.randf_range(70.0, 650.0))
	var dist = int(rng.randf_range(70.0, 650.0)) - global_position.y
	if dist <= 0:
		dist = dist * -1
	print(str(old_y))
	for i in range(dist):
		if new_y >= old_y:
			self.global_position.y += 1
			await get_tree().create_timer(0.1).timeout
		else:
			self.global_position.y -= 1
			await get_tree().create_timer(0.1).timeout

		
	
		#emit_signal("base_damage", damage)

func move(delta):
	if not progress_ratio == 1.0:
		set_progress(get_progress() + speed * delta)
		
	health_bar.set_position(position - Vector2(30, 30))

func on_hit(damage, type):
	var rand = (randi() % 5)
	impact(type)
	hp-= damage
	health_bar.value = hp
	if hp<=0:
		on_destroy()
	if(rand==4):
		get_node("Screach").play()

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
	#if not get_node("AnimationPlayer").is_playing():
	get_node("AnimationPlayer").play("Hit")

func on_destroy():
	emit_signal("death", GameData.enemy_data[type]["value"])
	get_node("CharacterBody2D").queue_free()
	await get_tree().create_timer(0.2).timeout
	self.queue_free()
