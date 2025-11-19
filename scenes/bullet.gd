extends Area2D

@export var texture_array : Array[Texture2D]

var speed = 300
var direction = Vector2.RIGHT
var bullet_type: int = 0
var random_bullet_giver: int = randi_range(0,3)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_bullet1_screen_exited() -> void:
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_bomb") and Global.bomb != 0 and Global.alive:
		queue_free()

func set_property(type) -> void:
	bullet_type = type
	$Sprite2D.texture = texture_array[type]

func _on_body_entered(body) -> void:
	body.set_status(bullet_type)

func _process(_delta) -> void:
	Global.started = true
	if Global.current_attack_pattern_type == "spiral":
		speed -= 1.45
	elif "rain" in Global.current_attack_pattern_type:
		speed -= 0.45
