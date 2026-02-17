extends Node

var pbDef = AudioServer.PLAYBACK_TYPE_DEFAULT

var playback:AudioStreamPlaybackPolyphonic
func _enter_tree() -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)

	var stream = AudioStreamPolyphonic.new()
	stream.polyphony = 4
	player.bus = "SFX"
	player.stream = stream
	player.play()

	playback = player.get_stream_playback()
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(_node:Node) -> void:
	print("Game audio ready!")

var hitSfx = preload("res://assets/sfx/bomb.ogg")
func damage_player(x):
	playback.play_stream(hitSfx,0,0,1.0,pbDef,"SFX")
	Global.health -= x

var healSfx = preload("res://assets/sfx/heal.ogg")
func heal_player(y):
	healSfx.play()
	Global.health += y

var getBombSfx = preload("res://assets/sfx/getbomb.ogg")
func give_player_bomb(z):
	getBombSfx.play()
	Global.bomb += z

func damage_boss(a):
	Global.boss_health -= a

func activate_spellcard(b,c):
	Global.is_spellcard = true
	Global.spellcard_id = b
	Global.spellcard_name = str(c)

func destroy_spellcard(_d):
	Global.is_spellcard = false
	Global.spellcard_id = 0
	Global.boss_spellcards -= 1
	if Global.can_capture_spellcard:
		print("Spellcard captured!!")
