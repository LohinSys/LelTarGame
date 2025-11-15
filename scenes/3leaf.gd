extends State

func enter() -> void:
	super.enter()
	owner.alpha = 2
	owner.bullet_type = 2

func transition() -> void:
	if can_transition:
		get_parent().change_state("2Leaf")
