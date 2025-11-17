extends CharacterBody2D

var theta = 0.0
@export_range(0,2*PI) var alpha: float = 0.0

@export var bullet1_node: PackedScene
var bullet_type = 0

func get_vector(angle):
	theta = angle + alpha
	return Vector2(cos(theta),sin(theta))

func shoot(angle) -> void:
	var bullet = bullet1_node.instantiate()
	
	bullet.position = global_position
	bullet.direction = get_vector(angle)
	bullet.set_property(bullet_type)
	
	get_tree().current_scene.call_deferred("add_child",bullet)

func _on_speed_timeout() -> void:
	shoot(theta)
	if Global.started and $Speed.wait_time >= 0.025:
		$Speed.wait_time -= 0.001
		Global.score2give += 1
		print("Current bullet speed: ", str($Speed.wait_time).pad_decimals(3), " seconds for next shot")

#func _physics_process(_delta) -> void:
	#velocity.x = -30.0
	#move_and_slide()
	#print(self.get_position())	# debug
