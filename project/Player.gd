extends Actor

const MOUSE_SENSITIVITY = 0.001

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _physics_process(delta):
	var motion = Vector2()
	if Input.is_action_pressed("move_forward"):
		motion.y = -1
	if Input.is_action_pressed("move_backward"):
		motion.y = 1
	if Input.is_action_pressed("move_left"):
		motion.x = -1
	if Input.is_action_pressed("move_right"):
		motion.x = 1
	self.set_motion(motion)
	
	if Input.is_action_just_pressed("jump"):
		self.jump()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(event.relative.x * MOUSE_SENSITIVITY*-1.0)
		self.look_up(-event.relative.y * MOUSE_SENSITIVITY)
