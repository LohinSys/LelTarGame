extends CharacterBody2D
class_name Player

var speed: float = 250.0

# some wall controller idk
var can_left: bool = true
var can_right: bool = true
var can_up: bool = true
var can_down: bool = true

func _input(event):
	if event.is_action_pressed("use_bomb") and Global.alive and Global.bomb != 0:
		$BombSfx.play()
		Global.bomb -= 1
		if !Global.fpsCapTooLow:
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

# the physics process is for inputs where you hold down a button
# note: WASD and shoot + focus buttons only work together on keyboards if it has 6-key rollover minimum
func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed

	if (!can_left and velocity.x < 0) or (!can_right and velocity.x > 0):
		velocity.x = 0
	if (!can_up and velocity.y < 0) or (!can_down and velocity.y > 0):
		velocity.y = 0

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

	# little death handler
	if Global.health <= 0:
		self.hide()

func pbd_wall_hit(plane:int) -> void:
	match plane:
		1: can_left = false
		2: can_right = false
		3: can_up = false
		4: can_down = false

func pbd_wall_leave(plane:int) -> void:
	match plane:
		1: can_left = true
		2: can_right = true
		3: can_up = true
		4: can_down = true

func graze() -> void:
	if Global.alive:
		Global.graze += 1
		$GrazeSfx.play()

func set_status(bullet_type) -> void:
	var amount = 10
	if Global.selectedDiff == 1: amount = 5
	else: amount = 10

	match bullet_type:
		0: hit(amount)
		1: hit(amount)
		2: hit(amount)
		3: hit(amount)

func hit(x) -> void:
	self.set_collision_layer_value(1, false)
	self.set_collision_mask_value(1, false)
	$AnimatedSprite2D.self_modulate = Color(1,1,1,0.5)
	%HitSfx.play()
	GameLogic.damage_player(x)

	await get_tree().create_timer(1).timeout
	self.set_collision_layer_value(1, true)
	self.set_collision_mask_value(1, true)
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
	if !Global.fpsCapTooLow:
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
