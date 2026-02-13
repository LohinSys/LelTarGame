extends Control

func _process(_delta) -> void:
	if Global.blurFx:
		$Blur.show()
	else:
		$Blur.hide()

	if Account.username != "":
		$Panel/CurrentPlayer.text = "You are currently playing as %s\nKeep in mind that you have account sync enabled." % Account.username
	else:
		$Panel/CurrentPlayer.text = "You are currently playing as a Guest.\nScores will only be saved locally."

func _on_exit_pressed() -> void:
	self.hide()

func _on_easy_pressed() -> void:
	Global.selectedDiff = 1
	start_game()
func _on_norm_pressed() -> void:
	Global.selectedDiff = 2
	start_game()
func _on_hard_pressed() -> void:
	Global.selectedDiff = 3
	start_game()
func _on_luna_pressed() -> void:
	Global.selectedDiff = 4
	start_game()

func start_game() -> void:
	Global.gameplayTitleSwitchSignal = true


func easy_desc() -> void:
	$Panel/DifficultyDesc.text = "Aimed at beginners, however the final stage is inaccessible here and scores from it cannot be submitted to online leaderboards."
func normal_desc() -> void:
	$Panel/DifficultyDesc.text = "The intended base difficulty, aimed at those who are average at bullet hell games."
func hard_desc() -> void:
	$Panel/DifficultyDesc.text = "Near arcade difficulty, aimed at those who's very experienced in bullet hell games."
func lunatic_desc() -> void:
	$Panel/DifficultyDesc.text = "Ridiculously difficult, not for the faint of heart."
func empty_desc() -> void:
	$Panel/DifficultyDesc.text = ""

func _on_easy_mouse_entered() -> void:
	easy_desc()
func _on_normal_mouse_entered() -> void:
	normal_desc()
func _on_hard_mouse_entered() -> void:
	hard_desc()
func _on_lunatic_mouse_entered() -> void:
	lunatic_desc()

func _on_easy_mouse_exited() -> void:
	empty_desc()
func _on_normal_mouse_exited() -> void:
	empty_desc()
func _on_hard_mouse_exited() -> void:
	empty_desc()
func _on_lunatic_mouse_exited() -> void:
	empty_desc()
