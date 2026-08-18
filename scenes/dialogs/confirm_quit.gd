extends ConfirmationDialog

func _on_confirmed() -> void:
	%LoadingScreen.show()
	PlayerStats.save()
	get_tree().quit(0)
