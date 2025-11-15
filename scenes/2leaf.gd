extends State

func enter() -> void:
	super.enter()
	owner.alpha = 3
	owner.bullet_type = 3

func transition() -> void:
	if can_transition:
		get_parent().change_state("5Leaf")
