extends CharacterBody2D

var speed = 1000
var accel = 10
var target
var distance

@onready var nav: NavigationAgent2D = $NavigationAgent2D
# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = get_parent().global_position
	target = get_parent().enemy.position
	get_node("AnimationPlayer").play("Start")
	distance = nav.distance_to_target()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2()
	print(nav.distance_to_target())
	if distance <= 50:
		speed = 500
	elif distance >= 51 and distance <= 500:
		speed = 1000
	elif distance >= 501:
		speed = 1250
	nav.target_position = target
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	look_at(nav.target_position)
	
	
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	move_and_slide()


func _on_navigation_agent_2d_target_reached():
	queue_free() # Replace with function body.
