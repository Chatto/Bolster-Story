extends Spatial
"""
	CameraController Scene Script
"""
# Change this to make it faster/slower
const LRSPEED: float = 1.5
# Change this to control how far down / up you can look
const DOWNMAX: int = -90
const UPMAX: int = 90

onready var lr: Spatial = $"LR"
onready var ud: Spatial = $"LR/UD"


func _physics_process(delta: float) -> void:
	# replace the input actions with your own
	lr.rotation.y += Input.get_action_strength("ui_left") * LRSPEED * delta
	lr.rotation.y -= Input.get_action_strength("ui_right") * LRSPEED * delta
	ud.rotation.x -= Input.get_action_strength("ui_up") * LRSPEED * delta
	ud.rotation.x += Input.get_action_strength("ui_down") * LRSPEED * delta
	ud.rotation_degrees.x = clamp(ud.rotation_degrees.x, DOWNMAX, UPMAX)
