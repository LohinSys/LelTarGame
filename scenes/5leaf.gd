extends State

func enter() -> void:
	super.enter()
	owner.alpha = 1.3
	owner.bullet_type = 0
	speed.start()

func transition() -> void:
	if can_transition:
		get_parent().change_state("4Leaf")
