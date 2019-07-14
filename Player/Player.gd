extends KinematicBody

export(int) var SPEED: int = 10
export(int) var GRAVITY: int = 10

onready var character: MeshInstance = $"CharacterMesh"

var rotation_speed: float = 0.0
var character_rotation: float = 0.0


func _physics_process(delta: float) -> void:
	
	# 1 Get Input
	var direction: Vector3 = Vector3()
	
	direction.z -= Input.get_action_strength("move_up")
	direction.z += Input.get_action_strength("move_down")
	direction.x -= Input.get_action_strength("move_left")
	direction.x += Input.get_action_strength("move_right")
	
	# Some controllers need a special type of normalizaion (Which i don't know.)
	direction = direction.normalized()
	
	# 2 Calculate Speeds
	var velocity: Vector3 = direction * SPEED
	
	# Gravity
	velocity.y = -1 * GRAVITY
	
	# 3 Apply Motion
	
	move_and_slide(velocity, Vector3.UP, true)
	
	# 4 Rotate the Model to smoothly look in the direction we were going.
	# Since we only rotate around one Axies, the math is done in 2 dimensions
	if direction.length() > 0:
		var target_dir: Vector2 = Vector2(velocity.z, velocity.x).normalized()
		var cur_dir := Vector2(1, 0).rotated(character_rotation)
		var new_rotation: float = cur_dir.linear_interpolate(target_dir, PI * 0.1).angle()
		
		rotation_speed = (character_rotation - new_rotation) * 10
		
		character_rotation = new_rotation
		
		# Apply the rotation
		# The rotation_speed variable can be feed to an AnimationTree blend space
		# This allows you to play turning animations
		character.rotation.y = new_rotation + PI
	
	# 5 Animation States (Once model is added)
	