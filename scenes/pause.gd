class_name pause_menu extends Control

@export var children : MarginContainer
@export var quitGameButton : Button
@export var resumeButton : Button
var ui_enabled : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	ui_enabled = false
	get_tree().paused = false
	self.visible = false

func exitGame() -> void:
	get_tree().quit()

func _on_resume_pressed() -> void:
	ui_enabled = false
	$Settings.hide()
	disableUI()

func _on_quit_game_pressed() -> void:
	exitGame()

func _on_back2title_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainMenuScenes/titleScreen.tscn")

func _on_settings_pressed() -> void:
	$Settings.show()
