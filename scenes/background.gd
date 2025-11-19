extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	move_local_y(10)
	if self.position == Vector2(0,1200):
		self.position = Vector2(0,0)
