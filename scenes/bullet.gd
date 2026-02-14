extends Area2D

@export var texture_array : Array[Texture2D]

var speed = 300
var direction = Vector2.RIGHT
var bullet_type: int = 0
var random_bullet_giver: int = randi_range(0,3)

var grazed: bool = false

var blown_up: bool = false
var bomb_bonus_formula: int = roundi((Global.score2give * Global.scoreMult) * ((Global.power * 5) + 5) + (roundf(Global.graze)/50)) + randi_range(-10,200)
var explosion_easing: float = 0.05

func _physics_process(delta: float) -> void:
	if !blown_up:
		position += direction * speed * delta
	else:
		$ScoreModLbl.position.y -= 0.8
		$Sprite2D.scale += Vector2(explosion_easing,explosion_easing)
		$Sprite2D.modulate -= Color(0,0,0,explosion_easing*1.2)
		if explosion_easing > 0:
			explosion_easing -= 0.0015

func _on_bullet1_screen_exited() -> void:
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_bomb") and Global.bomb != 0 and Global.alive and !blown_up:
		$CollisionShape2D.queue_free()
		$GrazeArea.queue_free()
		set_property(4)
		$Sprite2D.scale = Vector2(0.5,0.5)
		blown_up = true
		Global.score += bomb_bonus_formula
		$ScoreModLbl.text = str("+"+Global.num_with_thou_seps(bomb_bonus_formula))
		$ScoreModLbl.show()
		await get_tree().create_timer(0.9).timeout
		queue_free()

func set_property(type) -> void:
	bullet_type = type
	$Sprite2D.texture = texture_array[type]

func _on_body_entered(body) -> void:
	grazed = false
	body.set_status(bullet_type)

func _on_graze(body) -> void:
	grazed = true
	await get_tree().create_timer(0.1).timeout
	if grazed and Global.alive: body.graze()

func _process(_delta) -> void:
	Global.started = true
	if Global.current_attack_pattern_type == "spiral":
		speed -= 1.45
	elif "rain" in Global.current_attack_pattern_type:
		speed -= 0.45

	if bomb_bonus_formula < 0:
		bomb_bonus_formula = 0
