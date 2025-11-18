extends State

func enter() -> void:
	super.enter()
	Global.current_attack_pattern_type = "spiral"
	Global.random_bullets = false
	owner.alpha = 3
	owner.bullet_type = 3

func transition() -> void:
	if can_transition:
		get_parent().change_state("RainFromTop")
