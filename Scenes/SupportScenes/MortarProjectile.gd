extends Sprite2D

var bullet_speed = 360
var velocity
var enemy_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	set_global_position(get_parent().get_node("Turret/Muzzle").get_global_position())
	enemy_pos = get_parent().enemy.get_global_position()
	look_at(enemy_pos)
	
func _process(delta):
	velocity = (enemy_pos - get_global_position()).normalized()
	set_global_position(get_global_position() + velocity * delta * bullet_speed)
	if (int(get_global_position().x) / 10)==(int(enemy_pos.x) / 10) and (int(get_global_position().y) / 10)==(int(enemy_pos.y) /10):
		get_parent().explode()
		queue_free()
		
	
func _on_aoe_body_entered(body):
	get_parent().enemies_in_blast.append(body.get_parent())


func _on_aoe_body_exited(body):
	get_parent().enemies_in_blast.erase(body.get_parent())
