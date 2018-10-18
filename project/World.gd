extends Spatial

signal sig_level_finished
signal sig_died

const FinishOrb = preload("res://FinishOrb.tscn")
const Player = preload("res://Player.tscn")

var m_time = 0



func _cell_center(x,y,z):
	return $GridMap.map_to_world(x,y,z) #+ Vector3(1.0, 1.0, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = Player.instance()
	add_child(player)
	player.translate(_cell_center(0, 40, 0))
	player.look_up(-PI / 2.0)
	player.rotate_y(3.0*PI/4.0)

func start_game(rseed):
	var grid = $GridMap
	
	var m2d = Maze2D.new()
	m2d.set_seed(rseed)
	var width = 10
	var length = 10
	var border_height = 1
	
	m2d.build(grid, width, length, 0)

	# add floor	
	for y in range(0, length*2-1):
		for x in range(0, width*2-1):
			grid.set_cell_item(x,-1,y, 1)

	# add walls
	for z in range(0, border_height):
		for y in range(-1, length*2):
			grid.set_cell_item(-1, z, y, 0)
			grid.set_cell_item(width*2-1, z, y, 0)
	
		for x in range(0, length*2-1):
			grid.set_cell_item(x, z, -1, 0)
			grid.set_cell_item(x, z, length*2-1, 0)

	# TODO: pick random spot for finish orb

	var finishOrb = FinishOrb.instance()
	add_child(finishOrb)
	finishOrb.translate(_cell_center(width*2-2, 0, length*2-2))
	finishOrb.connect("sig_finished", self, "_on_finish")

func _physics_process(delta):
	m_time += delta
	var hours = int(m_time / (60*60))
	var minutes = int((m_time/60) - (hours*60))
	var seconds = m_time - (((hours*60)+minutes)*60)
	$Label.text = "%02d:%02d:%02.1f" % [hours, minutes, seconds]

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _on_finish():
	emit_signal("sig_level_finished", m_time)


