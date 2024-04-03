extends CharacterBody2D

var speed = 1000
var accel = 10
var distance

@onready var target = get_parent().enemy.position
@onready var target_progress = get_parent().enemy.progress
@onready var explosion_effect = preload("res://Scenes/SupportScenes/MissileExp.tscn")
@onready var nav = $NavigationAgent2D
# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = get_parent().global_position
	get_node("AnimationPlayer").play("Start")
	distance = nav.distance_to_target()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2()
	
	nav.target_position = target
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	look_at(nav.target_position)
	
	
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	move_and_slide()



func _on_navigation_agent_2d_target_reached():
	get_parent().get_parent().get_parent().get_node("Path2D").add_child(explosion_effect.instantiate())
	get_parent().get_parent().get_parent().get_node("Path2D/MissileExp").start(target_progress)
	queue_free()
	
	
 # Replace with function body.
