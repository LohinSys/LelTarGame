extends Node3D

var random_dir = [1, -1]
var camera_rotation: float = 0.001 * (random_dir[randi()%2])
var trans_to_cloud_layer: int = 2
var transition_now: bool = false

@onready var layer_1 = $"2D/Clouds/Layer-1"
@onready var layer_2 = $"2D/Clouds/Layer-2"
@onready var fade_transition = $"2D/Clouds/FadeTransition"

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
	layer_1.move_local_y(2)
	layer_2.move_local_y(2)
	$"2D/Clouds".move_local_x(camera_rotation)

	if transition_now:
		match trans_to_cloud_layer:
			1: # transition to layer 1
				layer_1.show()
				layer_1.self_modulate += Color(0, 0, 0, 1.0/240.0)
				layer_2.self_modulate -= Color(0, 0, 0, 1.0/240.0)
			2: # and layer 2
				layer_2.show()
				layer_2.self_modulate += Color(0, 0, 0, 1.0/240.0)
				layer_1.self_modulate -= Color(0, 0, 0, 1.0/240.0)

func _ready() -> void:
	fade_transition.start()

# what to do when it's nearly gonna clip away
func _on_cloud_fade_transition_timeout() -> void:
	transition_now = true
	match trans_to_cloud_layer:
		1: # reset pos of layer 1
			layer_1.position.y = 0
		2: # and layer 2
			layer_2.position.y = 0

	await get_tree().create_timer(4.0).timeout

	transition_now = false
	match trans_to_cloud_layer:
		1:	# swap to layer 2 for next transition
			trans_to_cloud_layer = 2
			layer_2.hide()
			layer_2.position.y = 0
		2:	# and layer 1
			trans_to_cloud_layer = 1
			layer_1.hide()
			layer_1.position.y = 0

	fade_transition.wait_time = randf_range(30.0,36.0)
	fade_transition.start()
