extends Control

func _on_exit_pressed() -> void:
	self.hide()

func _on_easy_pressed() -> void:
	Global.selectedDiff = 1
	start_game()
func _on_norm_pressed() -> void:
	Global.selectedDiff = 2
	start_game()
func _on_hard_pressed() -> void:
	Global.selectedDiff = 3
	start_game()
func _on_luna_pressed() -> void:
	Global.selectedDiff = 4
	start_game()

func start_game() -> void:
	pass
