extends Node

var setting = ConfigFile.new()

var masterVolume: float = 0.5
var sfxVolume: float = 1.0
var musicVolume: float = 1.0

var windowMode: int = 0
var antiAliasType: int = 0

var vSync: bool = true
var blurFx: bool = false
var showFps: bool = true
var showDbgInfo: bool = true

var alive: bool = true
var started: bool = false

var score2give: int = 1

var dbgInfoPrint = str("v",ProjectSettings.get_setting("application/config/version"),"\nRenderer: ",RenderingServer.get_current_rendering_driver_name(),"\n3D Background Test")

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
var random_bullets: bool = false

func update_window_mode() -> void:
	match windowMode:
		0:	# Windowed mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:	# Fullscreen mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func update_antialias_type() -> void:
	# These variables are just for shit that appear more than once cuz Godot wouldn't let me just use numbers
	var viewport: RID = get_tree().get_root().get_viewport_rid()
	var no_msaa = RenderingServer.VIEWPORT_MSAA_DISABLED
	var no_ssaa = RenderingServer.VIEWPORT_SCREEN_SPACE_AA_DISABLED

	match antiAliasType:
		0:	# No antialias
			RenderingServer.viewport_set_msaa_2d(viewport,no_msaa)
			RenderingServer.viewport_set_msaa_3d(viewport,no_msaa)
			RenderingServer.viewport_set_screen_space_aa(viewport,no_ssaa)
		1:	# FXAA
			RenderingServer.viewport_set_msaa_2d(viewport,no_msaa)
			RenderingServer.viewport_set_msaa_3d(viewport,no_msaa)
			RenderingServer.viewport_set_screen_space_aa(viewport,RenderingServer.VIEWPORT_SCREEN_SPACE_AA_FXAA)
		2: # SMAA
			RenderingServer.viewport_set_msaa_2d(viewport,no_msaa)
			RenderingServer.viewport_set_msaa_3d(viewport,no_msaa)
			RenderingServer.viewport_set_screen_space_aa(viewport,RenderingServer.VIEWPORT_SCREEN_SPACE_AA_SMAA)
		3:	# MSAA x2
			RenderingServer.viewport_set_msaa_2d(viewport,RenderingServer.VIEWPORT_MSAA_2X)
			RenderingServer.viewport_set_msaa_3d(viewport,RenderingServer.VIEWPORT_MSAA_2X)
			RenderingServer.viewport_set_screen_space_aa(viewport,no_ssaa)
		4:	# MSAA x4
			RenderingServer.viewport_set_msaa_2d(viewport,RenderingServer.VIEWPORT_MSAA_4X)
			RenderingServer.viewport_set_msaa_3d(viewport,RenderingServer.VIEWPORT_MSAA_4X)
			RenderingServer.viewport_set_screen_space_aa(viewport,no_ssaa)
		5:	# MSAA x8
			RenderingServer.viewport_set_msaa_2d(viewport,RenderingServer.VIEWPORT_MSAA_8X)
			RenderingServer.viewport_set_msaa_3d(viewport,RenderingServer.VIEWPORT_MSAA_8X)
			RenderingServer.viewport_set_screen_space_aa(viewport,no_ssaa)

func update_fps_display(fpsNode) -> void:
	fpsNode.set_text("%d fps" % Engine.get_frames_per_second())

func _ready() -> void:
	var sErr = setting.load("user://settings.ini")
	if sErr == OK:
		masterVolume = setting.get_value("Volume", "master")
		sfxVolume = setting.get_value("Volume", "sfx")
		musicVolume = setting.get_value("Volume", "music")

		windowMode = setting.get_value("Graphics", "mode")
		antiAliasType = setting.get_value("Graphics", "antiAliasType")
		vSync = setting.get_value("Graphics", "vSync")
		blurFx = setting.get_value("Graphics", "blurFx")
		showFps = setting.get_value("Graphics", "showFps")
		showDbgInfo = setting.get_value("Graphics", "showDbgInfo")
	else:
		return

	update_window_mode()
	update_antialias_type()

func change_scene_to_node(node):
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	tree.get_root().add_child(node)
	tree.get_root().remove_child(cur_scene)
	tree.set_current_scene(node)
