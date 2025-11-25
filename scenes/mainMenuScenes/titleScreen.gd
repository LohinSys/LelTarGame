extends CanvasLayer

func _ready() -> void:
	$How2Play.hide()
	$Settings.hide()
	$LoadingScreen.hide()
	$DbgInfo.set_text(str("v",ProjectSettings.get_setting("application/config/version")))

func _process(_delta) -> void:
	$Fps.set_text("%d fps" % Engine.get_frames_per_second())

	if Global.showFps:
		$Fps.show()
		$Fps.set_text("%d fps" % Engine.get_frames_per_second())
	else:
		$Fps.hide()
	if Global.showDbgInfo:
		$DbgInfo.show()
	else:
		$DbgInfo.hide()

func _on_start_game_pressed() -> void:
	$LoadingScreen.show()
	await get_tree().create_timer(0.1).timeout
	if $Settings.visible == true:
		$Settings.hide()
	get_tree().change_scene_to_file("res://scenes/bossRoom.tscn")

func _on_how2play_pressed() -> void:
	$How2Play.show()

func _on_quit_game_pressed() -> void:
	$LoadingScreen.show()
	get_tree().quit()

func _on_settings_pressed() -> void:
	$Settings.show()
