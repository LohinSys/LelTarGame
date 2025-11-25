extends Node

var setting = ConfigFile.new()

var masterVolume: float = 0.5
var sfxVolume: float = 1.0
var musicVolume: float = 1.0

var windowMode: int = 0

var vSync: bool = true
var blurFx: bool = false
var showFps: bool = true
var showDbgInfo: bool = true

var alive = true
var started = false

var score2give = 1

var health = 100:
	set(value):
		health = value

var bomb = 3:
	set(value):
		bomb = value

var power = 0.0:
	set(value):
		power = value

var graze = 0:
	set(value):
		graze = value

var boss_spellcard_time = 0.0:
	set(value):
		boss_spellcard_time = value

var current_attack_pattern_type: String = ""
var random_bullets = false

func update_window_mode():
	match windowMode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _ready() -> void:
	var sErr = setting.load("user://settings.ini")
	if sErr == OK:
		masterVolume = setting.get_value("Volume", "master")
		sfxVolume = setting.get_value("Volume", "sfx")
		musicVolume = setting.get_value("Volume", "music")

		windowMode = setting.get_value("Window", "mode")

		vSync = setting.get_value("Graphics", "vSync")
		blurFx = setting.get_value("Graphics", "blurFx")
		showFps = setting.get_value("Graphics", "showFps")
		showDbgInfo = setting.get_value("Graphics", "showDbgInfo")
	else:
		return

	update_window_mode()

func change_scene_to_node(node):
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	tree.get_root().add_child(node)
	tree.get_root().remove_child(cur_scene)
	tree.set_current_scene(node)
