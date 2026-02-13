extends Control

@onready var window_mode_dd = $Panel/MarginContainer/SettingsContainer/HBoxContainerG0/WindowModeContainer/Options
@onready var antialias_dd = $Panel/MarginContainer/SettingsContainer/HBoxContainerG0/AntiAliasingContainer/Options
@onready var anisotropy_dd = $Panel/MarginContainer/SettingsContainer/HBoxContainerG1/AnisotropyContainer/Options
@onready var scale_3d_dd = $Panel/MarginContainer/SettingsContainer/HBoxContainerG1/Scale3DContainer/Options

@onready var vsync_btn = $Panel/MarginContainer/SettingsContainer/HBoxContainerG2/VSyncContainer/Option
@onready var blur_fx_btn = $Panel/MarginContainer/SettingsContainer/HBoxContainerG2/BlurFXContainer/Option
@onready var show_fps_btn = $Panel/MarginContainer/SettingsContainer/HBoxContainerG2/ShowFpsContainer/Option
@onready var show_dbg_btn = $Panel/MarginContainer/SettingsContainer/HBoxContainerG2/ShowDbgContainer/Option

func _ready() -> void:
	window_mode_dd.selected = Global.windowMode
	antialias_dd.selected = Global.antiAliasType
	anisotropy_dd.selected = Global.anisotropy
	scale_3d_dd.selected = Global.scale3d

	%MasterVolSlider.value = Global.masterVolume
	%SFXVolSlider.value = Global.sfxVolume
	%MusicVolSlider.value = Global.musicVolume

func _process(_delta: float) -> void:
	if Global.blurFx:
		$Blur.show()
	else:
		$Blur.hide()

	%MasterVolValue.text = str(%MasterVolSlider.value*100).pad_decimals(0) + "%"
	%SFXVolValue.text = str(%SFXVolSlider.value*100).pad_decimals(0) + "%"
	%MusicVolValue.text = str(%MusicVolSlider.value*100).pad_decimals(0) + "%"
	vsync_btn.button_pressed = Global.vSync
	blur_fx_btn.button_pressed = Global.blurFx
	show_fps_btn.button_pressed = Global.showFps
	show_dbg_btn.button_pressed = Global.showDbgInfo

func _on_window_mode_selected(index: int) -> void:
	Global.windowMode = index
	Global.update_window_mode()

func _on_antialias_selected(index: int) -> void:
	Global.antiAliasType = index
	Global.update_antialias_type()

func _on_anisotropy_selected(index: int) -> void:
	Global.anisotropy = index
	Global.update_anisotropy()

func _on_scaling_3d_mode_selected(index: int) -> void:
	Global.scale3d = index
	Global.update_3d_scale()

func _on_vsync_pressed() -> void:
	if Global.vSync:
		Global.vSync = false
	else:
		Global.vSync = true
	Global.update_vsync()

func _on_blurFx_pressed() -> void:
	if Global.blurFx:
		Global.blurFx = false
	else:
		Global.blurFx = true

func _on_showFps_pressed() -> void:
	if Global.showFps:
		Global.showFps = false
	else:
		Global.showFps = true

func _on_showDbg_pressed() -> void:
	if Global.showDbgInfo:
		Global.showDbgInfo = false
	else:
		Global.showDbgInfo = true


func save_settings() -> void:
	Global.setting.set_value("Volume", "master", %MasterVolSlider.value)
	Global.setting.set_value("Volume", "sfx", %SFXVolSlider.value)
	Global.setting.set_value("Volume", "music", %MusicVolSlider.value)

	Global.setting.set_value("Graphics", "windowMode", Global.windowMode)
	Global.setting.set_value("Graphics", "antiAliasType", Global.antiAliasType)
	Global.setting.set_value("Graphics", "anisotropy", Global.anisotropy)
	Global.setting.set_value("Graphics", "scale3d", Global.scale3d)
	Global.setting.set_value("Graphics", "vSync", Global.vSync)
	Global.setting.set_value("Graphics", "blurFx", Global.blurFx)
	Global.setting.set_value("Graphics", "showFps", Global.showFps)
	Global.setting.set_value("Graphics", "showDbgInfo", Global.showDbgInfo)

	Global.setting.save("user://settings.ini")

func _on_done_pressed() -> void:
	save_settings()
	self.hide()

func _on_master_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_sfx_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))

func _on_music_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
