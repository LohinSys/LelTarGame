class_name pause_menu extends Control

@export var children : MarginContainer
@export var quitGameButton : Button
@export var resumeButton : Button
var ui_enabled : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LoadingScreen.hide()
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	disableUI()

func _input(event):
	if event.is_action_pressed("pause"):
		if ui_enabled:
			disableUI()
		else:
			enableUI()

func enableUI() -> void:
	ui_enabled = true
	get_tree().paused = true
	self.visible = true


func disableUI() -> void:
	$Settings.hide()
	$How2Play.hide()
	ui_enabled = false
	get_tree().paused = false
	self.visible = false

func exitGame() -> void:
	$LoadingScreen.show()
	get_tree().quit()

func _on_resume_pressed() -> void:
	ui_enabled = false
	disableUI()

func _on_quit_game_pressed() -> void:
	exitGame()

func _on_back2title_pressed() -> void:
	$LoadingScreen.show()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/mainMenuScenes/titleScreen.tscn")

func _on_settings_pressed() -> void:
	$Settings.show()

func _on_how2play_pressed() -> void:
	$How2Play.show()
