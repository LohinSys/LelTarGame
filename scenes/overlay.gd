extends CanvasLayer

@onready var health_bar = $playerStatsContainer/healthBar
@onready var bomb_bar = $playerStatsContainer/bombBar
@onready var graze_count = $playerStatsContainer/grazeContainer/grazeCount
@onready var final_score = $GameOver/GameOverContainer/GameOverFSCount

@export var menu_button : Button

var score = 0:
	set(value):
		score = value
		%scoreCount.text = str(value).pad_zeros(9)

var hi_score = 500_000:
	set(value):
		hi_score = value
		%hiScoreCount.text = str(value).pad_zeros(9)

var bs_timer = Global.boss_spellcard_time:
	set(value):
		%SpellcardTimerLabel.text = str(value).pad_decimals(0)
		%SpellcardTimerDecimal.text = str(value).pad_decimals(1).right(1)


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
	if event.is_action_pressed("use_bomb") and Global.alive and Global.bomb != 0:
		Global.bomb -= 1

#func set_status() -> void:

func _ready() -> void:
	$version.set_text(str("v",ProjectSettings.get_setting("application/config/version")))

func _process(_delta) -> void:
	if Global.alive and Global.started:
		$startGameInstruct.hide()
		%SpellcardTimerContainer.show()
		$BossBarBackground.show()
		%BossBarContainer.show()
		score += (Global.score2give * (Global.graze+1))

		if 200_000 >= score and score >= 50_000:
			Global.power = 0.5
		elif 500_000 >= score and score >= 200_000:
			Global.power = 1.2
		elif 825_000 >= score and score >= 500_000:
			Global.power = 2.0
		elif 975_000 >= score and score >= 825_000:
			Global.power = 2.9
		elif 1_250_000 >= score and score >= 975_000:
			Global.power = 3.4
		elif score >= 1_250_000:
			Global.power = 4.0

	if !Global.alive:
		if score > hi_score:
			hi_score = score
		final_score.text = str(score)
		$GameOver.visible = true
		if Global.started:
			Global.power = Global.power * 0.625
			Global.started = false

	dhealth = Global.health
	bombs = Global.bomb
	power_lvl = Global.power
	bs_timer = Global.boss_spellcard_time


	$debugInfo.set_text("%d fps" % Engine.get_frames_per_second())


func _on_menu_button_pressed() -> void:
	$PauseMenu.enableUI()
