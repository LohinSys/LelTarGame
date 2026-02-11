extends CanvasLayer

@onready var health_bar = $playerStatsContainer/healthBar
@onready var bomb_bar = $playerStatsContainer/bombBar
@onready var graze_count = $playerStatsContainer/grazeContainer/grazeCount
@onready var final_score = $GameOver/GameOverContainer/GameOverFSCount
@onready var score_mult_display = $GameOver/GameOverContainer/GameOverFSScoreMult

@onready var diff_label = $playerStatsContainer/difficultyLabel

@export var menu_button : Button

var score: int = Global.score:
	set(value):
		score = value
		Global.score = value
		%scoreCount.text = str(value).pad_zeros(9)

var hi_score: int = 0:
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

var bombs: int = Global.bomb:
	set(value):
		bombs = value
		bomb_bar.value = value

var power_lvl: float = Global.power:
	set(value):
		power_lvl = value
		%powerCount.text = str(value).left(1)
		%powerCountDecimal.text = str(value).pad_decimals(1).right(1)

var scoreMult: float = 1.0:
	set(value):
		scoreMult = value
		$scoreContainer/HBoxContainer/scoreMultLabel.text = "x%s" % value

func _ready() -> void:
	$DbgInfo.set_text(Global.dbgInfoPrint)
	Global.score = 0

	if Account.loggedIn:
		$scoreContainer/playerNameValue.text = Account.username
		$GameOver/GameOverContainer/GameOverFSSaveMsg.text = "(Leaderboard submissions are not implemented\nyet, so your score will only be saved locally.)"
	else:
		$scoreContainer/playerNameValue.text = "Guest"
		$GameOver/GameOverContainer/GameOverFSSaveMsg.text = "(Leaderboard submissions are disabled on guest\naccounts, so your score will only be saved locally.)"

	match Global.selectedDiff:
		1: # Easy
			diff_label.text = "Easy"
			diff_label.add_theme_color_override("font_outline_color",Color(0x30ff60ff))
			score_mult_display.add_theme_color_override("font_color",Color(0x30ff60ff))
			scoreMult = 0.75
			PlayerStats.easyTimesPlayed += 1
			hi_score = PlayerStats.easyHiScore
		2: # Normal
			diff_label.text = "Normal"
			diff_label.add_theme_color_override("font_outline_color",Color(0x00a4ffff))
			score_mult_display.add_theme_color_override("font_color",Color(0x00a4ffff))
			scoreMult = 1.0
			PlayerStats.normTimesPlayed += 1
			hi_score = PlayerStats.normHiScore
		3: # Hard
			diff_label.text = "Hard"
			diff_label.add_theme_color_override("font_outline_color",Color(0xff4040ff))
			score_mult_display.add_theme_color_override("font_color",Color(0xff4040ff))
			scoreMult = 1.25
			PlayerStats.hardTimesPlayed += 1
			hi_score = PlayerStats.hardHiScore
		4: # Lunatic
			diff_label.text = "Lunatic"
			diff_label.add_theme_color_override("font_outline_color",Color(0xeb60ffff))
			score_mult_display.add_theme_color_override("font_color",Color(0xeb60ffff))
			scoreMult = 1.5
			PlayerStats.lunaTimesPlayed += 1
			hi_score = PlayerStats.lunaHiScore

	if scoreMult > 1.0:
		$scoreContainer/HBoxContainer/scoreMultLabel.add_theme_color_override("font_color",Color(0x29d952ff))
	elif scoreMult < 1.0:
		$scoreContainer/HBoxContainer/scoreMultLabel.add_theme_color_override("font_color",Color(0xd93636ff))
	else:
		$scoreContainer/HBoxContainer/scoreMultLabel.add_theme_color_override("font_color",Color(0xd9d9d9ff))

	score_mult_display.text = "Score Mult.: x%s (%s)" % [str(scoreMult),diff_label.text]

func _process(_delta) -> void:
	if Global.alive and Global.started:
		$startGameInstruct.hide()
		%SpellcardTimerContainer.show()
		$BossBarBackground.show()
		%BossBarContainer.show()

		Global.score += roundi( (Global.score2give * (Global.graze+1)) * scoreMult )
		score = Global.score

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
		$AliveIndicator.hide()

	dhealth = Global.health
	bombs = Global.bomb
	power_lvl = Global.power
	bs_timer = Global.boss_spellcard_time


	if Global.showFps:
		$Fps.show()
		Global.update_fps_display($Fps)
	else:
		$Fps.hide()
	if Global.showDbgInfo:
		$DbgInfo.show()
	else:
		$DbgInfo.hide()

func _on_menu_button_pressed() -> void:
	$PauseMenu/SfxDecide.play()
	$PauseMenu.enableUI()

func _on_alive_indicator_hidden() -> void:
	if Global.score > hi_score:
		hi_score = Global.score
		match Global.selectedDiff:
			1:	# Easy
				PlayerStats.easyHiScore = hi_score
			2:	# Normal
				PlayerStats.normHiScore = hi_score
			3:	# Hard
				PlayerStats.hardHiScore = hi_score
			4:	# Lunatic
				PlayerStats.lunaHiScore = hi_score
	final_score.text = Global.num_with_thou_seps(score)
	$GameOver.visible = true

	Global.power = Global.power * 0.625
	Global.started = false

	PlayerStats.save()
