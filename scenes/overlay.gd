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
		if Global.score > 999_999_999: %scoreCount.text = "999999999"
		else: %scoreCount.text = str(value).pad_zeros(9)

var hi_score: int = 0:
	set(value):
		hi_score = value
		if Global.score > 999_999_999: %hiScoreCount.text = "999999999"
		else: %hiScoreCount.text = str(value).pad_zeros(9)

var bs_timer: float = Global.boss_spellcard_time:
	set(value):
		%SpellcardTimerLabel.text = str(value).pad_decimals(0)
		%SpellcardTimerDecimal.text = str(value).pad_decimals(1).right(1)


var dhealth: int = Global.health:
	set(value):
		dhealth = value
		health_bar.value = value
		%healthCount.text = str(value," / 80")

var bombs: int = Global.bomb:
	set(value):
		bombs = value
		bomb_bar.value = value
		%bombCount.text = str(value," / 8")

var power_lvl: float = Global.power:
	set(value):
		power_lvl = value
		%powerCount.text = str(value).left(1)
		%powerCountDecimal.text = str(value).pad_decimals(1).right(1)

var graze: int = Global.graze:
	set(value):
		graze = value
		graze_count.text = str(Global.num_with_thou_seps(value))

var scoreMult: float = Global.scoreMult:
	set(value):
		scoreMult = value
		$scoreContainer/HBoxContainer/scoreMultLabel.text = "x%s" % value

var boss_hp: int = Global.boss_health:
	set(value):
		boss_hp = value
		%BossBarHealth.value = value

var boss_spells: int = Global.boss_spellcards:
	set(value):
		boss_spells = value
		%BossBarSpellcards.value = value

func _ready() -> void:
	$DbgInfo.set_text(Global.dbgInfoPrint)
	Global.started = false
	Global.score = 0
	Global.score2give = 1

	Global.health = 80
	Global.bomb = 3
	Global.power = 0.0
	Global.graze = 0

	Global.current_attack_pattern = ""
	Global.current_attack_pattern_type = ""

	Global.boss_health = 1000
	Global.boss_spellcards = 3
	Global.boss_spellcard_time = 0.0
	Global.alive = true

	$AliveIndicator.show()
	$GameOver.hide()

	%BossBarNameTag.text = "undefined!"

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
			Global.scoreMult = 0.75
			PlayerStats.easyTimesPlayed += 1
			hi_score = PlayerStats.easyHiScore
		2: # Normal
			diff_label.text = "Normal"
			diff_label.add_theme_color_override("font_outline_color",Color(0x00a4ffff))
			score_mult_display.add_theme_color_override("font_color",Color(0x00a4ffff))
			Global.scoreMult = 1.0
			PlayerStats.normTimesPlayed += 1
			hi_score = PlayerStats.normHiScore
		3: # Hard
			diff_label.text = "Hard"
			diff_label.add_theme_color_override("font_outline_color",Color(0xff4040ff))
			score_mult_display.add_theme_color_override("font_color",Color(0xff4040ff))
			Global.scoreMult = 1.25
			PlayerStats.hardTimesPlayed += 1
			hi_score = PlayerStats.hardHiScore
		4: # Lunatic
			diff_label.text = "Lunatic"
			diff_label.add_theme_color_override("font_outline_color",Color(0xeb60ffff))
			score_mult_display.add_theme_color_override("font_color",Color(0xeb60ffff))
			Global.scoreMult = 1.5
			PlayerStats.lunaTimesPlayed += 1
			hi_score = PlayerStats.lunaHiScore

	scoreMult = Global.scoreMult

	if scoreMult > 1.0:
		$scoreContainer/HBoxContainer/scoreMultLabel.add_theme_color_override("font_color",Color(0x29d952ff))
	elif scoreMult < 1.0:
		$scoreContainer/HBoxContainer/scoreMultLabel.add_theme_color_override("font_color",Color(0xd93636ff))
	else:
		$scoreContainer/HBoxContainer/scoreMultLabel.add_theme_color_override("font_color",Color(0xd9d9d9ff))

	score_mult_display.text = "Score Mult.: x%s (%s)" % [str(scoreMult),diff_label.text]

func _physics_process(_delta) -> void:
	if Global.alive and Global.started:
		$startGameInstruct.hide()
		%SpellcardTimerContainer.show()
		$BossBarBackground.show()
		%BossBarContainer.show()

		%BossBarNameTag.text = "Ayane Hanako"

		Global.score += roundi( (Global.score2give * ((roundf(Global.graze)/10)+1)) * Global.scoreMult )
		score = Global.score

		if 75_000 >= score and score >= 50_000:
			Global.power = 0.5
		elif 400_000 >= score and score >= 350_000:
			Global.power = 1.2
		elif 700_000 >= score and score >= 675_000:
			Global.power = 2.0
		elif 999_000 >= score and score >= 960_000:
			Global.power = 2.9
		elif 2_105_000 >= score and score >= 2_000_000:
			Global.power = 3.4
		elif 5_050_050 >= score and score >= 5_000_000:
			Global.power = 4.0

	if !Global.alive:
		$AliveIndicator.hide()
		Global.health = 0

	dhealth = Global.health
	bombs = Global.bomb
	power_lvl = Global.power
	graze = Global.graze

	boss_hp = Global.boss_health
	boss_spells = Global.boss_spellcards

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
	%BGA.stop()
	$GameOver.show()

	Global.power = Global.power * 0.625
	Global.started = false

	PlayerStats.save()

func _on_start_game_instruct_hidden() -> void:
	%BGA.play()
