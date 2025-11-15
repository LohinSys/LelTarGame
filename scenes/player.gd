extends CharacterBody2D

var speed = 250
@onready var debug = $debug
@onready var progress_bar = $ProgressBar

var health = 100:
	set(value):
		health = value
		progress_bar.value = value

func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * speed
	move_and_slide()

func set_status(bullet_type) -> void:
	match bullet_type:
		0: fire()
		1: poison()
		2: slow()
		3: stun()

func fire() -> void:
	debug.text = "fire"
	health -= 10

func poison() -> void:
	debug.text = "poison"
	for i in range(5):
		health -= 2
		await get_tree().create_timer(1).timeout

func slow() -> void:
	debug.text = "slow"
	speed = 50
	await get_tree().create_timer(5).timeout
	speed = 250

func stun() -> void:
	debug.text = "stun"
	speed = 0
	await get_tree().create_timer(2).timeout
	speed = 250
