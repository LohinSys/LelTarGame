extends CanvasLayer

@onready var health_bar = $playerStatsContainer/healthBar
@onready var bomb_bar = $playerStatsContainer/bombBar
@onready var power_count = $playerStatsContainer/powerContainer/powerCountContainer/powerCount
@onready var power_count_decimal = $playerStatsContainer/powerContainer/powerCountContainer/powerCountDecimal
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

func _input(event):
	if event.is_action_pressed("use_bomb") and Global.alive:
		bombs -= 1

#func set_status() -> void:

func _ready() -> void:
	$version.set_text(str(ProjectSettings.get_setting("application/config/version")))

func _process(_delta) -> void:
	if Global.alive and Global.started:
		score += Global.score2give
	else:
		pass
	
	if !Global.alive:
		hi_score = score
		final_score.text = str(score)
		$GameOver.visible = true
	
	dhealth = Global.health

	$debugInfo.set_text("%d fps" % Engine.get_frames_per_second())
