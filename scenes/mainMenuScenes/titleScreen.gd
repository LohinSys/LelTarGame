extends CanvasLayer

func _ready() -> void:
	$Version.set_text(str("v",ProjectSettings.get_setting("application/config/version")))

func _process(_delta) -> void:
	$DebugInfo.set_text("%d fps" % Engine.get_frames_per_second())

func _on_start_game_pressed() -> void:
	if $Settings.visible == true:
		$Settings.hide()
	get_tree().change_scene_to_file("res://scenes/bossRoom.tscn")

func _on_how2play_pressed() -> void:
	pass

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	$Settings.show()
