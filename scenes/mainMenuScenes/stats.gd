extends Control

func _ready() -> void:
	# Times Played
	%StatRunEasy.text = str(Global.num_with_thou_seps(PlayerStats.easyTimesPlayed))
	%StatRunNorm.text = str(Global.num_with_thou_seps(PlayerStats.normTimesPlayed))
	%StatRunHard.text = str(Global.num_with_thou_seps(PlayerStats.hardTimesPlayed))
	%StatRunLuna.text = str(Global.num_with_thou_seps(PlayerStats.lunaTimesPlayed))
	# Best Run (Stage)
	%StatBestRunEasy.text = str("Stage ", Global.num_with_thou_seps(PlayerStats.easyBestRun))
	%StatBestRunNorm.text = str("Stage ", Global.num_with_thou_seps(PlayerStats.normBestRun))
	%StatBestRunHard.text = str("Stage ", Global.num_with_thou_seps(PlayerStats.hardBestRun))
	%StatBestRunLuna.text = str("Stage ", Global.num_with_thou_seps(PlayerStats.lunaBestRun))
	# High Scores
	%StatBestScoreEasy.text = str(Global.num_with_thou_seps(PlayerStats.easyHiScore))
	%StatBestScoreNorm.text = str(Global.num_with_thou_seps(PlayerStats.normHiScore))
	%StatBestScoreHard.text = str(Global.num_with_thou_seps(PlayerStats.hardHiScore))
	%StatBestScoreLuna.text = str(Global.num_with_thou_seps(PlayerStats.lunaHiScore))
	# Total Deaths
	%StatDeathsEasy.text = str(Global.num_with_thou_seps(PlayerStats.easyDeaths))
	%StatDeathsNorm.text = str(Global.num_with_thou_seps(PlayerStats.normDeaths))
	%StatDeathsHard.text = str(Global.num_with_thou_seps(PlayerStats.hardDeaths))
	%StatDeathsLuna.text = str(Global.num_with_thou_seps(PlayerStats.lunaDeaths))
	# Bombs Used
	%StatBombsEasy.text = str(Global.num_with_thou_seps(PlayerStats.easyBombsUsed))
	%StatBombsNorm.text = str(Global.num_with_thou_seps(PlayerStats.normBombsUsed))
	%StatBombsHard.text = str(Global.num_with_thou_seps(PlayerStats.hardBombsUsed))
	%StatBombsLuna.text = str(Global.num_with_thou_seps(PlayerStats.lunaBombsUsed))
	# Bullets Grazed
	%StatGrazeEasy.text = str(Global.num_with_thou_seps(PlayerStats.easyGrazed))
	%StatGrazeNorm.text = str(Global.num_with_thou_seps(PlayerStats.normGrazed))
	%StatGrazeHard.text = str(Global.num_with_thou_seps(PlayerStats.hardGrazed))
	%StatGrazeLuna.text = str(Global.num_with_thou_seps(PlayerStats.lunaGrazed))

func _physics_process(_delta) -> void:
	if Global.blurFx:
		$Blur.show()
	else:
		$Blur.hide()

func _on_exit_pressed() -> void:
	self.hide()
