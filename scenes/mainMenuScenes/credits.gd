extends Control

#@export var credits_pages : Array[Texture2D]

func _physics_process(_delta) -> void:
	if Global.blurFx:
		$Blur.show()
	else:
		$Blur.hide()

func _on_exit_pressed() -> void:
	self.hide()
