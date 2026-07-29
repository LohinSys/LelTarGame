extends Control

#@export var credits_pages : Array[Texture2D]

func _ready() -> void:
	var ver = Engine.get_version_info()
	var ver_string: String
	if ver.patch < 1:
		ver_string = "%s.%s" % [ver.major,ver.minor]
	else:
		ver_string = "%s.%s.%s" % [ver.major,ver.minor,ver.patch]

	$Panel/GodotVer.text = "Made with Godot Engine %s\nhttps://godotengine.org/" % ver_string

func _physics_process(_delta) -> void:
	if Global.blurFx: $Blur.show()
	else: $Blur.hide()

func _on_exit_pressed() -> void: self.hide()
