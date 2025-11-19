extends CharacterBody2D

var theta = 0.0
@export_range(0,2*PI) var alpha: float = 0.0
@export_range(0,1) var alphaV: float = 0.0

@export var bullet1_node: PackedScene
var bullet_type = 0
var alternating_top_bottom = 0
var alternating_direction = 1

func get_vector(angle):
	theta = angle + alpha
	return Vector2(cos(theta),sin(theta))

func shoot(angle) -> void:
	var bullet = bullet1_node.instantiate()

	if Global.current_attack_pattern_type == "spiral":
		bullet.position = global_position
		bullet.direction = get_vector(angle)
	elif Global.current_attack_pattern_type == "rainUp":
		bullet.position = Vector2((randi_range(2,7)*80)+30,0)
		bullet.direction = Vector2(0,1)
	elif Global.current_attack_pattern_type == "rainDown":
		bullet.position = Vector2((randi_range(2,7)*80)+50,600)
		bullet.direction = Vector2(0,-1)
	elif Global.current_attack_pattern_type == "rainUpDown":
		bullet.position = Vector2((randi_range(2,7)*80)+50,alternating_top_bottom)
		bullet.direction = Vector2(0,alternating_direction)
		if alternating_direction == 1:
			alternating_top_bottom = 0
		elif alternating_direction == -1:
			alternating_top_bottom = 600
	if Global.random_bullets:
		bullet.set_property(randi_range(0,3))
	else:
		bullet.set_property(bullet_type)

	get_tree().current_scene.call_deferred("add_child",bullet)

func _on_speed_timeout() -> void:
	shoot(theta)
	if Global.started and $Speed.wait_time == 0.500:
		%Spellcard.start()
		%Spellcard.autostart = true
		Global.boss_spellcard_time += 0.5
	if Global.started and $Speed.wait_time >= 0.025:
		$Speed.wait_time -= 0.001
		Global.score2give += 1
		print("Current bullet speed: ", str($Speed.wait_time).pad_decimals(3), " seconds for next shot")
	if !Global.alive:
		if $Speed.wait_time == 0.025:
			$Speed.wait_time = 0.001
		%Spellcard.stop()

func _ready() -> void:
	$AnimatedSprite2D.play()

func _on_spellcard_timeout() -> void:
	Global.boss_spellcard_time += 0.1
