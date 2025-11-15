extends State

func enter() -> void:
	super.enter()
	owner.alpha = 1.5
	owner.bullet_type = 1

func transition() -> void:
	if can_transition:
		get_parent().change_state("3Leaf")
