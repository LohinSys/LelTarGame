extends Node3D

func _physics_process(_delta: float) -> void:
	$StaticBody3D.rotate_x(0.02)
	$StaticBody3D.rotate_y(0.02)
	$StaticBody3D.rotate_z(0.02)
	#$Layer1.move_local_y(10)
	#$Layer2.move_local_y(30)
	#if $Layer1.position == Vector2(0,1200):
		#$Layer1.position = Vector2(0,0)
	#if $Layer2.position == Vector2(0,2400):
		#$Layer2.position = Vector2(0,-1200)
