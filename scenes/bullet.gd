extends Area2D

@export var texture_array : Array[Texture2D]

var speed = 300
var direction = Vector2.RIGHT
var bullet_type: int = 0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_bullet1_screen_exited() -> void:
	queue_free()

func set_property(type) -> void:
	bullet_type = type
	$Sprite2D.texture = texture_array[type]

func _on_body_entered(body) -> void:
	body.set_status(bullet_type)

func _process(_delta) -> void:
	Global.started = true
	speed -= 1.45
