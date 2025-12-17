extends HSlider

@export var audio_bus_name := "SFX"
@onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready() -> void:
	self.value = Global.sfxVolume
	AudioServer.set_bus_volume_db(_bus, linear_to_db(self.value))

func _on_master_vol_slider_value_changed() -> void:
	AudioServer.set_bus_volume_db(_bus, linear_to_db(self.value))
	Global.sfxVolume = value
