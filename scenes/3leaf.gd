extends State

func enter() -> void:
	super.enter()
	Global.current_attack_pattern_type = "spiral"
	Global.random_bullets = false
	owner.alpha = 2
	owner.bullet_type = 2

func transition() -> void:
	if can_transition:
		get_parent().change_state("2Leaf")
