extends Node2D

func _physics_process(_delta) -> void:
	self.move_local_x(-0.5)
	if self.position <= Vector2(-800,0):
		self.position = Vector2(0,0)
