extends CharacterBody2D
class_name Player

const default_speed = 250.0
var speed = default_speed:
	set(value):
		speed = value

@onready var player_dbg = $playerDbg

var health = Global.health:
	set(value):
		health = value

# csak egyszer nyomsz meg egy gombot
func _input(event):
	if event.is_action_pressed("use_bomb"):
		pass
	if event.is_action_pressed("pause"):
		pass

# gomb lenyomásra
func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed
	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		speed = default_speed * 0.8
	elif Input.is_action_just_released("shoot"):
		speed = default_speed

	if Input.is_action_just_pressed("focus"):
		speed = default_speed / 2
		$VisibleCS2D.visible = true
	elif Input.is_action_just_released("focus"):
		speed = default_speed
		$VisibleCS2D.visible = false

	if Global.health <= 0:
		self.queue_free()
		Global.alive = false

func set_status(bullet_type) -> void:
	match bullet_type:
		0: fire()
		1: poison()
		2: slow()
		3: stun()

func fire() -> void:
	player_dbg.text = "fire"
	Global.health -= 10

func poison() -> void:
	player_dbg.text = "poison"
	for i in range(10):
		Global.health -= 1
		await get_tree().create_timer(0.5).timeout

func slow() -> void:
	player_dbg.text = "frostbite"
	Global.health -= 20
	await get_tree().create_timer(5).timeout
	speed = default_speed
	Global.health += 15

func stun() -> void:
	player_dbg.text = "shock"
	Global.health -= 30
	for i in range(25):
		Global.health += 1
		await get_tree().create_timer(0.5).timeout
