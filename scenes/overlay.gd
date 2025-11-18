extends CanvasLayer

@onready var health_bar = $playerStatsContainer/healthBar
@onready var bomb_bar = $playerStatsContainer/bombBar
@onready var graze_count = $playerStatsContainer/grazeContainer/grazeCount
@onready var final_score = $GameOver/GameOverContainer/GameOverFSCount

var score = 0:
	set(value):
		score = value
		%scoreCount.text = str(value).pad_zeros(9)

var hi_score = 0:
	set(value):
		hi_score = value
		%hiScoreCount.text = str(value).pad_zeros(9)

var dhealth = Global.health:
	set(value):
		dhealth = value
		health_bar.value = value

var bombs = Global.bomb:
	set(value):
		bombs = value
		bomb_bar.value = value

var power_lvl = Global.power:
	set(value):
		power_lvl = value
		%powerCount.text = str(value).left(1)
		%powerCountDecimal.text = str(value).pad_decimals(1).right(1)

func _input(event):
	if event.is_action_pressed("use_bomb") and Global.alive:
		Global.bomb -= 1

#func set_status() -> void:

func _ready() -> void:
	$version.set_text(str(ProjectSettings.get_setting("application/config/version")))

func _process(_delta) -> void:
	if Global.alive and Global.started:
		score += Global.score2give

		if 200000 >= score and score >= 50000:
			Global.power = 0.5
		elif 500000 >= score and score >= 200000:
			Global.power = 1.2
		elif 825000 >= score and score >= 500000:
			Global.power = 2.0
		elif 975000 >= score and score >= 825000:
			Global.power = 2.9
		elif 1250000 >= score and score >= 975000:
			Global.power = 3.4
		elif score >= 1250000:
			Global.power = 4.0
	else:
		pass



	if !Global.alive:
		if score > 500000:
			hi_score = score
		final_score.text = str(score)
		$GameOver.visible = true
		if !Global.started:
			Global.power = Global.power * 0.625
			Global.started = false

	dhealth = Global.health
	bombs = Global.bomb
	power_lvl = Global.power


	$debugInfo.set_text("%d fps" % Engine.get_frames_per_second())
