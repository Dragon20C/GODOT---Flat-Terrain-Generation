extends KinematicBody

var mouse_sensitivity = 0.2
var focus = true
var movement = Vector3()
onready var fps = $UI/CenterContainer/FPS
onready var ray = $Head/Camera/RayCast
func _ready():
	pass
	
func _input(event):
		if event is InputEventMouseMotion:
			rotation_degrees.y  -= event.relative.x * mouse_sensitivity
			$Head.rotation_degrees.x = clamp($Head.rotation_degrees.x - event.relative.y * mouse_sensitivity, -90,90)
		
func _process(delta):
	fps.set_text("FPS : " + str(Engine.get_frames_per_second()))
	if Input.is_action_just_pressed("ui_cancel"):
		focus = !focus
		get_tree().quit()
	if !focus:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	movement = Vector3()
	if Input.is_action_pressed("w"):
		movement -= transform.basis.z
	if Input.is_action_pressed("a"):
		movement -= transform.basis.x
	if Input.is_action_pressed("s"):
		movement += transform.basis.z
	if Input.is_action_pressed("d"):
		movement += transform.basis.x
	if Input.is_action_pressed("Up"):
		movement += transform.basis.y
	if Input.is_action_pressed("Down"):
		movement -= transform.basis.y
		
	move_and_slide(movement * 15,Vector3.UP)
