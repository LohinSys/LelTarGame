extends Node3D

func _physics_process(_delta: float) -> void:
	$"Ground3D-1".move_and_collide(Vector3(0,0,0.05))
	$"Ground3D-2".move_and_collide(Vector3(0,0,0.05))
	$"Ground3D-3".move_and_collide(Vector3(0,0,0.05))
	if $"Ground3D-1".position >= Vector3(0,-1,20):
		$"Ground3D-1".position = Vector3(0,-1,-39)
	if $"Ground3D-2".position >= Vector3(0,-1,20):
		$"Ground3D-2".position = Vector3(0,-1,-39)
	if $"Ground3D-3".position >= Vector3(0,-1,20):
		$"Ground3D-3".position = Vector3(0,-1,-39)
