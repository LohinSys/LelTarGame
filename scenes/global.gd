extends Node

var setting = ConfigFile.new()

var masterVolume: float = 0.5
var sfxVolume: float = 1.0
var musicVolume: float = 1.0

var windowMode: int = 0
var antiAliasType: int = 0
var anisotropy: int = 2
var scale3d: int = 4

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
	var no_screen_space_aa = RenderingServer.VIEWPORT_SCREEN_SPACE_AA_DISABLED

	match antiAliasType:
		0:	# No antialias
			RenderingServer.viewport_set_msaa_2d(viewport,no_msaa)
			RenderingServer.viewport_set_msaa_3d(viewport,no_msaa)
			RenderingServer.viewport_set_screen_space_aa(viewport,no_screen_space_aa)
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
			RenderingServer.viewport_set_screen_space_aa(viewport,no_screen_space_aa)
		4:	# MSAA x4
			RenderingServer.viewport_set_msaa_2d(viewport,RenderingServer.VIEWPORT_MSAA_4X)
			RenderingServer.viewport_set_msaa_3d(viewport,RenderingServer.VIEWPORT_MSAA_4X)
			RenderingServer.viewport_set_screen_space_aa(viewport,no_screen_space_aa)
		5:	# MSAA x8
			RenderingServer.viewport_set_msaa_2d(viewport,RenderingServer.VIEWPORT_MSAA_8X)
			RenderingServer.viewport_set_msaa_3d(viewport,RenderingServer.VIEWPORT_MSAA_8X)
			RenderingServer.viewport_set_screen_space_aa(viewport,no_screen_space_aa)

func update_anisotropy() -> void:
	var viewport: RID = get_tree().get_root().get_viewport_rid()
	var anisotropic_req = RenderingServer.CANVAS_ITEM_TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC

	match anisotropy:
		0: # Disabled
			RenderingServer.canvas_item_set_default_texture_filter(viewport,RenderingServer.CANVAS_ITEM_TEXTURE_FILTER_LINEAR_WITH_MIPMAPS)
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_DISABLED)
		1: # 2x
			RenderingServer.canvas_item_set_default_texture_filter(viewport,anisotropic_req)
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_2X)
		2: # 4x
			RenderingServer.canvas_item_set_default_texture_filter(viewport,anisotropic_req)
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_4X)
		3: # 8x
			RenderingServer.canvas_item_set_default_texture_filter(viewport,anisotropic_req)
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_8X)
		4: # 16x
			RenderingServer.canvas_item_set_default_texture_filter(viewport,anisotropic_req)
			RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_16X)

func update_3d_scale() -> void:
	var viewport: RID = get_tree().get_root().get_viewport_rid()
	match scale3d:
		0:	# 200%
			RenderingServer.viewport_set_scaling_3d_scale(viewport,2.0)
		1:	# 175%
			RenderingServer.viewport_set_scaling_3d_scale(viewport,1.75)
		2:	# 150%
			RenderingServer.viewport_set_scaling_3d_scale(viewport,1.5)
		3:	# 125%
			RenderingServer.viewport_set_scaling_3d_scale(viewport,1.25)
		4:	# 100%
			RenderingServer.viewport_set_scaling_3d_scale(viewport,1.0)
		5:	# 75%
			RenderingServer.viewport_set_scaling_3d_scale(viewport,0.75)
		6:	# 50%
			RenderingServer.viewport_set_scaling_3d_scale(viewport,0.5)
		7:	# 25%
			RenderingServer.viewport_set_scaling_3d_scale(viewport,0.25)

func update_fps_display(fpsNode) -> void:
	fpsNode.set_text("%d fps" % Engine.get_frames_per_second())

func _ready() -> void:
	print("Lel.tar ",dbgInfoPrint,"\nCopyleft LohinSys (ɔ) 2024-2025")

	var sErr = setting.load("user://settings.ini")
	if sErr == OK:
		masterVolume = setting.get_value("Volume", "master")
		sfxVolume = setting.get_value("Volume", "sfx")
		musicVolume = setting.get_value("Volume", "music")

		windowMode = setting.get_value("Graphics", "windowMode")
		antiAliasType = setting.get_value("Graphics", "antiAliasType")
		anisotropy = setting.get_value("Graphics", "anisotropy")
		scale3d = setting.get_value("Graphics", "scale3d")
		vSync = setting.get_value("Graphics", "vSync")
		blurFx = setting.get_value("Graphics", "blurFx")
		showFps = setting.get_value("Graphics", "showFps")
		showDbgInfo = setting.get_value("Graphics", "showDbgInfo")
	else:
		return

	update_window_mode()
	update_antialias_type()
	update_anisotropy()
	update_3d_scale()

#func change_scene_to_node(node):
	#var tree = get_tree()
	#var cur_scene = tree.get_current_scene()
	#tree.get_root().add_child(node)
	#tree.get_root().remove_child(cur_scene)
	#tree.set_current_scene(node)
