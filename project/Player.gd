extends Actor

const MOUSE_SENSITIVITY = 0.001

const Flour = preload("res://Flour.tscn")

export (int) var flour_amount = 50


signal sig_update
signal sig_died

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



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
	
	if Input.is_action_just_pressed("drop_flour"):
		drop_flour()


func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			self.rotate_y(event.relative.x * MOUSE_SENSITIVITY*-1.0)
			self.look_up(-event.relative.y * MOUSE_SENSITIVITY)


func drop_flour():
	if $FlourTimer.is_stopped() and flour_amount > 0:
		emit_signal("sig_update", self)
		flour_amount -= 1
		$FlourTimer.start()
		var f = Flour.instance()
		
		# cast a ray straight down from the player
		var ray = $DownRay
		ray.force_raycast_update()
		if ray.is_colliding():
			var body = ray.get_collider()
			var world = body.get_parent()
			f.translate(ray.get_collision_point())
			f.rotate_y(rand_range(0, PI*2))
			world.add_child(f)

func die():
	emit_signal("sig_died")
