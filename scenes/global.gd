extends Node

var masterVolume = 0.5
var sfxVolume = 1.0
var musicVolume = 1.0

var alive = true
var started = false

var score2give = 1

var health = 100:
	set(value):
		health = value

var bomb = 3:
	set(value):
		bomb = value

var power = 0.0:
	set(value):
		power = value

var graze = 0:
	set(value):
		graze = value

var boss_spellcard_time = 0.0:
	set(value):
		boss_spellcard_time = value

var current_attack_pattern_type: String = ""
var random_bullets = false

func change_scene_to_node(node):
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	tree.get_root().add_child(node)
	tree.get_root().remove_child(cur_scene)
	tree.set_current_scene(node)
