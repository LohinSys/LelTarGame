extends Control

func _physics_process(_delta) -> void:
	if Global.blurFx:
		$Blur.show()
	else:
		$Blur.hide()

func _on_exit_pressed() -> void:
	self.hide()
