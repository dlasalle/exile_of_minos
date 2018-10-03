extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var grid = $GridMap
	
	var m2d = Maze2D.new()
	m2d.set_seed(2)
	var width = 10
	var length = 10
	var border_height = 3
	
	m2d.build(grid, width, length, 0)

	# add floor	
	for y in range(0, length*2-1):
		for x in range(0, width*2-1):
			grid.set_cell_item(x,-1,y, 0)

	# add walls
	for z in range(0, border_height):
		for y in range(-1, length*2):
			grid.set_cell_item(-1, z, y, 0)
			grid.set_cell_item(width*2-1, z, y, 0)
	
		for x in range(0, length*2-1):
			grid.set_cell_item(x, z, -1, 0)
			grid.set_cell_item(x, z, length*2-1, 0)

	# add start
	grid.set_cell_item(-1, -1, 0, 0)
	grid.set_cell_item(-1, 0, 0, -1)
	grid.set_cell_item(-1, 4, 0, 0)
	
	grid.set_cell_item(width*2-2, -1, length*2-1, 0)
	grid.set_cell_item(width*2-2, 0, length*2-1, -1)
	grid.set_cell_item(width*2-2, 4, length*2-1, 0)