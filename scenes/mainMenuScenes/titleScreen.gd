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

	if Global.blurFx:
		$Blur.show()
	else:
		$Blur.hide()

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
	$BgMusic.stop()
	$LoadingScreen.show()
	await get_tree().create_timer(0.1).timeout
	if $Settings.visible == true:
		$Settings.hide()
	get_tree().change_scene_to_file("res://scenes/bossRoom.tscn")

# UI audio handler
var playback:AudioStreamPlaybackPolyphonic
func _enter_tree() -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)

	var stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	player.bus = "SFX"
	player.stream = stream
	player.play()

	playback = player.get_stream_playback()
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node:Node) -> void:
	if node is Button:
		node.mouse_entered.connect(_play_hover_sfx)
		node.pressed.connect(_play_press_sfx)

var selectSfx = preload("res://assets/sfx/select.ogg")
func _play_hover_sfx() -> void:
	playback.play_stream(selectSfx,0,0,1.0,AudioServer.PLAYBACK_TYPE_DEFAULT)

var decideSfx = preload("res://assets/sfx/decide.ogg")
func _play_press_sfx() -> void:
	playback.play_stream(decideSfx,0,0,1.0,AudioServer.PLAYBACK_TYPE_DEFAULT)
