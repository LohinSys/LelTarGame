extends CanvasLayer

func _ready() -> void:
	$GameModeSel.hide()
	$How2Play.hide()
	$Settings.hide()
	$LoadingScreen.hide()
	$DbgInfo.set_text(Global.dbgInfoPrint)

	await get_tree().create_timer(0.5).timeout
	if !Account.loggedIn:
		%LoginTitleButton.disabled = false
	if Account.loginSuccess:
		%AccountLabel.text = "Welcome, %s!\nOnline sync is not available." % Account.username
		%LoginTitleButton.hide()
		%LogoutTitleButton.show()

func _process(_delta) -> void:
	Global.update_fps_display($Fps)

	if Global.showFps:
		$Fps.show()
	else:
		$Fps.hide()
	if Global.showDbgInfo:
		$DbgInfo.show()
	else:
		$DbgInfo.hide()

	if Global.gameplayTitleSwitchSignal:
		Global.gameplayTitleSwitchSignal = false
		start_game()

func _on_start_game_pressed() -> void:
	$GameModeSel.show()

func _on_how2play_pressed() -> void:
	$How2Play.show()

func _on_statistics_pressed() -> void:
	$Stats.show()

func _on_settings_pressed() -> void:
	$Settings.show()

func _on_credits_pressed() -> void:
	$Credits.show()

func _on_quit_game_pressed() -> void:
	$LoadingScreen.show()
	PlayerStats.save()
	get_tree().quit()

func _on_login_button_pressed() -> void:
	%LoginTitleButton.disabled = true
	$Login.show()

func _on_login_hidden() -> void:
	%LoginTitleButton.disabled = false
	if Account.loginSuccess:
		%LoginTitleButton.hide()
		%LogoutTitleButton.show()

func _on_logout_button_pressed() -> void:
	%LogoutTitleButton.disabled = true
	%LoginTitleButton.disabled = false
	if Account.loggedIn:
		Account.logoff()
		%AccountLabel.text = "Welcome, Guest!\nYou are not logged in."
		%LogoutTitleButton.hide()
		%LoginTitleButton.show()
	%LogoutTitleButton.disabled = false

func start_game() -> void:
	$LoadingScreen.show()
	await get_tree().create_timer(0.1).timeout
	if $Settings.visible == true:
		$Settings.hide()
	get_tree().change_scene_to_file("res://scenes/bossRoom.tscn")
