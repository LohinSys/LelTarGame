extends CanvasLayer

var current_step: String = "fade_in"

func _ready() -> void:
	$Logo1.modulate = Color(1,1,1,0)
	$Logo1/Timer.start()

func _physics_process(d) -> void:
	match current_step:
		"fade_in":
			if $Logo1.modulate != Color(1,1,1,1):
				$Logo1.modulate += Color(0,0,0,d)
			else:
				current_step = "idle"
		"fade_out":
			if $Logo1.modulate != Color(1,1,1,0):
				$Logo1.modulate -= Color(0,0,0,d)
			else:
				current_step = "idle"

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("shoot") and current_step != "fade_out":
		$Logo1/Timer.stop()
		_on_logo1_timer_timeout()

func _on_logo1_timer_timeout() -> void:
	$Logo1.modulate = Color(1,1,1,1)
	current_step = "fade_out"
	await get_tree().create_timer(1.05).timeout
	get_tree().change_scene_to_file("res://scenes/mainMenuScenes/titleScreen.tscn")
