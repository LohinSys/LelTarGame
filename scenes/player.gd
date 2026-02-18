extends CharacterBody2D
class_name Player

var speed = 250.0:
	set(value):
		speed = value

var health = Global.health:
	set(value):
		health = value

func _input(event):
	if event.is_action_pressed("use_bomb") and Global.alive and Global.bomb != 0:
		$BombSfx.play()
		Global.bomb -= 1
		match Global.selectedDiff:
			1:	# Easy
				PlayerStats.easyBombsUsed += 1
			2:	# Normal
				PlayerStats.normBombsUsed += 1
			3:	# Hard
				PlayerStats.hardBombsUsed += 1
			4:	# Lunatic
				PlayerStats.lunaBombsUsed += 1

func _ready() -> void:
	$AnimatedSprite2D.play()

# gomb lenyomásra
func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed
	move_and_slide()

	# these variables are needed otherwise the player will start going apeshit
	var shooting = Input.is_action_just_pressed("shoot")
	var not_shooting = Input.is_action_just_released("shoot")
	var focusing = Input.is_action_just_pressed("focus")
	var not_focusing = Input.is_action_just_released("focus")

	if shooting:
		speed *= 0.8
	if focusing:
		speed /= 2
		$VisibleCS2D.show()
	if not_shooting:
		speed /= 0.8
	if not_focusing:
		speed *= 2
		$VisibleCS2D.hide()

	if Global.health <= 0:
		self.hide()

func graze() -> void:
	Global.graze += 1
	$GrazeSfx.play()

func set_status(bullet_type) -> void:
	var amount = 10
	if Global.selectedDiff == 1 or Global.selectedDiff == 2: amount = 5
	else: amount = 10

	match bullet_type:
		0: hit(amount)
		1: hit(amount)
		2: hit(amount)
		3: hit(amount)

func hit(x) -> void:
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimatedSprite2D.self_modulate = Color(1,1,1,0.5)
	%HitSfx.play()
	GameLogic.damage_player(x)

	await get_tree().create_timer(1).timeout
	$CollisionShape2D.set_deferred("disabled",false)
	$AnimatedSprite2D.self_modulate = Color(1,1,1,1)

func heal(y) -> void:
	%HealSfx.play()
	GameLogic.heal_player(y)

func give_bomb(z) -> void:
	%GetBombSfx.play()
	GameLogic.give_player_bomb(z)

func give_more_points() -> void:
	Global.bonusFormula = roundi((Global.score2give * Global.scoreMult) * ((Global.power * 5) + 5) + (roundf(Global.graze)/50)) + randi_range(-10,200)
	Global.score += Global.bonusFormula

func _on_death() -> void:
	Global.alive = false
	$DeathSfx.play()
	match Global.selectedDiff:
		1:	# Easy
			PlayerStats.easyDeaths += 1
			PlayerStats.easyGrazed += Global.graze
		2:	# Normal
			PlayerStats.normDeaths += 1
			PlayerStats.normGrazed += Global.graze
		3:	# Hard
			PlayerStats.hardDeaths += 1
			PlayerStats.hardGrazed += Global.graze
		4:	# Lunatic
			PlayerStats.lunaDeaths += 1
			PlayerStats.lunaGrazed += Global.graze
	await get_tree().create_timer(1.5).timeout
	self.queue_free()
