extends Control

func _process(_delta: float) -> void:
	%MasterVolValue.text = str(%MasterVolSlider.value*100).pad_decimals(0) + "%"
	%SFXVolValue.text = str(%SFXVolSlider.value*100).pad_decimals(0) + "%"
	%MusicVolValue.text = str(%MusicVolSlider.value*100).pad_decimals(0) + "%"

func _on_done_pressed() -> void:
	self.hide()
