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
var blurFx: bool = true
var showFps: bool = true
var showDbgInfo: bool = true

var fpsCap: int = 60
var fpsCapTooLow: bool = false

var gameplayTitleSwitchSignal: bool = false
var alive: bool = true
var started: bool = false
var selectedDiff: int = 0

var score: int = 0
var scoreMult: float = 1.0

var score2give = 1
var bonusFormula: int = 0:
	set(value):
		bonusFormula = value
		if bonusFormula < 0: bonusFormula = 0

var verNote: String = "Suddenly, prettier!"
var renderer: String = "-"

var dbgInfoPrint: String = "v0.0.0\nRenderer: -"

var health = 80:
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

var boss_health: int = 1000
var boss_spellcards: int = 3
var is_spellcard: bool = false
var spellcard_id: int = 0
var spellcard_name: String = ""
var can_capture_spellcard: bool = true

var current_attack_pattern: String = ""
var current_attack_pattern_type: String = ""
var random_bullets: bool = false

func update_window_mode() -> void:
	match windowMode:
		0: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func update_vsync() -> void:
	match vSync:
		true: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		false: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

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

	match anisotropy:
		0: RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_DISABLED)
		1: RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_2X)
		2: RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_4X)
		3: RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_8X)
		4: RenderingServer.viewport_set_anisotropic_filtering_level(viewport,RenderingServer.VIEWPORT_ANISOTROPY_16X)

func update_3d_scale() -> void:
	var viewport: RID = get_tree().get_root().get_viewport_rid()
	match scale3d:
		0: RenderingServer.viewport_set_scaling_3d_scale(viewport,2.0)
		1: RenderingServer.viewport_set_scaling_3d_scale(viewport,1.75)
		2: RenderingServer.viewport_set_scaling_3d_scale(viewport,1.5)
		3: RenderingServer.viewport_set_scaling_3d_scale(viewport,1.25)
		4: RenderingServer.viewport_set_scaling_3d_scale(viewport,1.0)
		5: RenderingServer.viewport_set_scaling_3d_scale(viewport,0.75)
		6: RenderingServer.viewport_set_scaling_3d_scale(viewport,0.5)
		7: RenderingServer.viewport_set_scaling_3d_scale(viewport,0.25)

func update_volumes() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(masterVolume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfxVolume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(musicVolume))

func update_fps_cap() -> void:
	Engine.max_fps = Global.fpsCap

func update_fps_display(fpsNode) -> void:
	fpsNode.set_text("%d fps" % Engine.get_frames_per_second())
	if Engine.get_frames_per_second() < 16:
		fpsNode.modulate = Color(0xff6060ff)
	elif Engine.get_frames_per_second() < 60:
		fpsNode.modulate = Color(0xffc060ff)
	else:
		fpsNode.modulate = Color(0xffffffff)

func num_with_thou_seps(number: int) -> String:
	var num_str: String = str(number).lstrip("-")
	var result: String = ""
	var count: int = 0

	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result

	if number < 0:
		result = "-" + result

	return result

func load_settings() -> void:
	print("\nLoading settings...")

	var sErr = setting.load("user://settings.ini")
	if sErr == OK:
		masterVolume = setting.get_value("Volume", "master", 0.5)
		sfxVolume = setting.get_value("Volume", "sfx", 1.0)
		musicVolume = setting.get_value("Volume", "music", 1.0)

		windowMode = setting.get_value("Graphics", "windowMode", 0)
		antiAliasType = setting.get_value("Graphics", "antiAliasType", 0)
		anisotropy = setting.get_value("Graphics", "anisotropy", 2)
		scale3d = setting.get_value("Graphics", "scale3d", 4)
		vSync = setting.get_value("Graphics", "vSync", true)
		blurFx = setting.get_value("Graphics", "blurFx", true)
		showFps = setting.get_value("Graphics", "showFps", true)
		showDbgInfo = setting.get_value("Graphics", "showDbgInfo", true)
		fpsCap = setting.get_value("Graphics", "fpsCap", 60)
	else: return

	print("\nApplying settings:")
	print("Window Mode...")
	update_window_mode()
	print("Audio Volumes...")
	update_volumes()
	print("Vertical Sync...")
	update_vsync()
	print("Anti-aliasing...")
	update_antialias_type()
	print("Anisotropic Filtering...")
	update_anisotropy()
	print("3D Scale...")
	update_3d_scale()
	print("Finished applying settings!")

func _ready() -> void:
	match str(RenderingServer.get_current_rendering_driver_name()):
		"vulkan": renderer = "Vulkan"
		"d3d12": renderer = "Direct3D 12"
		"metal": renderer = "Metal"
		"opengl3": renderer = "OpenGL"
		"opengl3_es": renderer = "OpenGL ES"
		"opengl3_angle": renderer = "OpenGL ANGLE"

	dbgInfoPrint = str("v",ProjectSettings.get_setting("application/config/version")," - ",verNote,"\nRenderer: ",renderer)

	print_rich("[b]Lel.tar ",dbgInfoPrint,"\nLohinSys (ɔ) 2024-2026[/b]")

	load_settings()

	DisplayServer.window_set_title(str("Lel.tar ",ProjectSettings.get_setting("application/config/version")," - ",verNote),0)
