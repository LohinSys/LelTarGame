class_name pause_menu extends Control

@export var children : MarginContainer
@export var quitGameButton : Button
@export var resumeButton : Button
var ui_enabled : bool = false

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
	if node is BaseButton:
		node.mouse_entered.connect(_play_hover_sfx)
		node.pressed.connect(_play_press_sfx)

var selectSfx = preload("res://assets/sfx/select.ogg")
func _play_hover_sfx() -> void:
	playback.play_stream(selectSfx,0,0,1.0,AudioServer.PLAYBACK_TYPE_DEFAULT)

var decideSfx = preload("res://assets/sfx/decide.ogg")
func _play_press_sfx() -> void:
	playback.play_stream(decideSfx,0,0,1.0,AudioServer.PLAYBACK_TYPE_DEFAULT)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(Api.http_request)
	$LoadingScreen.hide()
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	disableUI()

func _physics_process(_delta) -> void:
	if Global.blurFx: $Blur.show()
	else: $Blur.hide()

func _input(event):
	if event.is_action_pressed("pause"):
		if ui_enabled: disableUI()
		else: enableUI()

func enableUI() -> void:
	_play_press_sfx()
	ui_enabled = true
	get_tree().paused = true
	self.show()

func disableUI() -> void:
	$Settings.hide()
	$How2Play.hide()
	ui_enabled = false
	get_tree().paused = false
	self.hide()

func _on_resume_pressed() -> void:
	ui_enabled = false
	disableUI()

func _on_restart_pressed() -> void:
	ui_enabled = false
	disableUI()
	remove_child(Api.http_request)
	$LoadingScreen.show()
	get_tree().reload_current_scene()

func _on_quit_game_pressed() -> void:
	$ConfirmQuit.show()

func _on_back2title_pressed() -> void:
	$ConfirmB2T.show()

func _on_confirm_b2t_confirmed() -> void:
	%LoadingScreen.show()
	remove_child(Api.http_request)
	PlayerStats.save()
	await get_tree().create_timer(0.1).timeout
	disableUI()
	get_tree().change_scene_to_file("res://scenes/mainMenuScenes/titleScreen.tscn")

func _on_settings_pressed() -> void: $Settings.show()

func _on_how2play_pressed() -> void: $How2Play.show()
