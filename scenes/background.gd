extends Node3D

var random_dir = [1, -1]
var camera_rotation: float = 0.001 * (random_dir[randi()%2])

func make_clouds(width,height,offset:Vector3):
	# initialize noise texture
	var texture = NoiseTexture2D.new()
	texture.noise = FastNoiseLite.new()
	# initialize gradient
	var gradient = Gradient.new()
	# gradient settings
	gradient.offsets = PackedFloat32Array([0.0,1.0])
	gradient.colors = PackedColorArray([Color(1,1,1,0),Color(1,1,1,0.33)])
	await gradient.changed

	# texture settings
	texture.width = width
	texture.height = height
	# noise settings
	texture.noise.set("seed",randi_range(0,2345678))
	texture.noise.set("frequency",0.0019)
	texture.noise.set("offset",offset)
	texture.noise.set("color_ramp",gradient)
	# noise -> fractal settings
	texture.noise.set("fractal_octaves",3)
	texture.noise.set("fractal_weighted_strength",0.5)

	await texture.changed

	#var image = texture.get_image()
	#var data = image.get_data()

	return texture

# initialize non-3D shit
func _ready() -> void:
	$Clouds2D.texture = await make_clouds(800,600,Vector3i(0,-500,0))

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
