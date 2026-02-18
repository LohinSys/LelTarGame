extends Node3D

var random_dir = [1, -1]
var camera_rotation: float = 0.001 * (random_dir[randi()%2])

func _physics_process(_delta) -> void:
	# keep moving the background
	$"Ground3D-1".move_and_collide(Vector3(0,0,0.025))
	$"Ground3D-2".move_and_collide(Vector3(0,0,0.025))
	$"Ground3D-3".move_and_collide(Vector3(0,0,0.025))
	# reset position so it loops infinitely
	if $"Ground3D-1".position.z >= 20:
		$"Ground3D-1".position.z = -39
	if $"Ground3D-2".position.z >= 20:
		$"Ground3D-2".position.z = -39
	if $"Ground3D-3".position.z >= 20:
		$"Ground3D-3".position.z = -39

	# bob around the camera
	$Camera3D.rotate_z(camera_rotation/2)
	$Camera3D.position.x -= float((camera_rotation*10)/2)
	if $Camera3D.rotation.z >= (19.0 / 100.0):
		if camera_rotation >= -0.001:
			camera_rotation -= 0.00001
	if $Camera3D.rotation.z <= (-19.0 / 100.0):
		if camera_rotation <= 0.001:
			camera_rotation += 0.00001
