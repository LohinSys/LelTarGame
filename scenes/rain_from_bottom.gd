extends State

func enter() -> void:
	super.enter()
	Global.current_attack_pattern_type = "rainDown"
	Global.random_bullets = true
	owner.alpha = 0
	owner.alphaV = 1
	speed.start()

func transition() -> void:
	if can_transition:
		get_parent().change_state("5Leaf")
