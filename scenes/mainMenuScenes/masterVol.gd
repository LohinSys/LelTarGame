extends HSlider

@export var audio_bus_name := "Master"
@onready var _bus := AudioServer.get_bus_index(audio_bus_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_master_vol_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))
	Global.masterVolume = value
