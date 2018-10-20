extends Spatial


export (int) var floor_height = 1
export (int) var wall_height = 2
export (int) var border_height = 2
export (int) var wall_width = 1
export (int) var floor_width = 1
export (int) var width = 10
export (int) var length = 10

const FinishOrb = preload("res://FinishOrb.tscn")

signal sig_finished

func _ready():
	pass # Replace with function body.

func _on_finish():
	emit_signal("sig_finished")

func cell_center(x,y,z):
	return $GridMap.map_to_world(x,y,z) #+ Vector3(1.0, 1.0, 1.0)


func generate(rseed):
	var grid = $GridMap
	
	var m2d = Maze2D.new()
	m2d.set_offset(0, 0, -1)
	m2d.set_seed(rseed)
	m2d.set_wall_height(wall_height)
	m2d.set_border_height(border_height)
	m2d.set_floor_id(1)
	m2d.set_wall_id(1)
	m2d.set_border_id(1)
	m2d.set_floor_height(floor_height-1)
	m2d.set_floor_width(floor_width)
	m2d.set_wall_width(wall_width)
	
	m2d.build(grid, width, length)

	# TODO: pick random spot for finish orb

	var finishOrb = FinishOrb.instance()
	add_child(finishOrb)
	finishOrb.translate(cell_center((width-1)*(floor_width+wall_width)+0.5*floor_width, floor_height-1,
		(length-1)*(floor_width+wall_width)+0.5*floor_width))
	finishOrb.connect("sig_finished", self, "_on_finish")
