extends Spatial

var m_time = 0

func timestamp():
	return OS.get_unix_time()

# Called when the node enters the scene tree for the first time.
func _ready():
	var grid = $Viewport/GridMap
	
	var m2d = Maze2D.new()
	m2d.set_seed(timestamp())
	var width = 10
	var length = 10
	var border_height = 4
	
	$Viewport/TopCamera.size = width*4+1
	$Viewport/TopCamera.transform.origin.x = width*2-1
	$Viewport/TopCamera.transform.origin.z = length*2-1
	
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

	# add start
	grid.set_cell_item(-1, -1, 0, 1)
	for z in range(0, border_height):
		grid.set_cell_item(-1, z, 0, -1)

	
	grid.set_cell_item(width*2-2, -1, length*2-1, 1)
	for z in range(0, border_height):
		grid.set_cell_item(width*2-2, z, length*2-1, -1)

func _physics_process(delta):
	m_time += delta
	var hours = int(m_time / (60*60))
	var minutes = int((m_time/60) - (hours*60))
	var seconds = m_time - (((hours*60)+minutes)*60)
	$Label.text = "%02d:%02d:%02.1f" % [hours, minutes, seconds]