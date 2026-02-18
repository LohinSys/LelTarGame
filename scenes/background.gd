extends Node3D

var random_dir = [1, -1]
var camera_rotation: float = 0.001 * (random_dir[randi()%2])
var trans_to_cloud_layer: int = 2
var transition_now: bool = false

# bg animation
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

	# move the clouds down
	$"Clouds2D/Layer-1".move_local_y(1)
	$"Clouds2D/Layer-2".move_local_y(1)

	if transition_now:
		match trans_to_cloud_layer:
			1: # transition to layer 1
				$"Clouds2D/Layer-1".show()
				$"Clouds2D/Layer-1".self_modulate += Color(0, 0, 0, 1.0/240.0)
				$"Clouds2D/Layer-2".self_modulate -= Color(0, 0, 0, 1.0/240.0)
			2: # and layer 2
				$"Clouds2D/Layer-2".show()
				$"Clouds2D/Layer-2".self_modulate += Color(0, 0, 0, 1.0/240.0)
				$"Clouds2D/Layer-1".self_modulate -= Color(0, 0, 0, 1.0/240.0)

# what to do when it's nearly gonna clip away
func _on_cloud_fade_transition_timeout() -> void:
	transition_now = true
	$Clouds2D/FadeTransition.wait_time = 56.25
	await get_tree().create_timer(4.0).timeout
	transition_now = false
	match trans_to_cloud_layer:
		1:	# swap to layer 2 for next transition
			trans_to_cloud_layer = 2
			$"Clouds2D/Layer-2".hide()
			$"Clouds2D/Layer-2".position.y = 0
		2:	# and layer 1
			trans_to_cloud_layer = 1
			$"Clouds2D/Layer-1".hide()
			$"Clouds2D/Layer-1".position.y = 0
