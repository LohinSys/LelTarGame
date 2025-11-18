extends Node

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


var current_attack_pattern_type: String = ""
var random_bullets = false
