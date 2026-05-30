extends Node

func damage_player(x):
	Global.health -= x

func heal_player(y):
	Global.health += y

func give_player_bomb(z):
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
	if Global.can_capture_spellcard: print("Spellcard captured!!")
