extends Spatial

export (int) var floor_id = 0
export (int) var wall_id = 1
export (int) var border_id = 1
export (int) var ceiling_id = 1
export (int) var floor_height = 1
export (int) var wall_height = 2
export (int) var border_height = 2
export (int) var wall_width = 1
export (int) var floor_width = 1
export (bool) var has_ceiling = false
export (int) var width = 10
export (int) var length = 10
export (int) var player_spawn_height = 25
export (bool) var last = false

const FinishOrb = preload("res://FinishOrb.tscn")
const FinishBull = preload("res://FinishBull.tscn")

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
	m2d.set_floor_id(floor_id)
	m2d.set_wall_id(wall_id)
	m2d.set_border_id(wall_id)
	m2d.set_wall_height(wall_height)
	m2d.set_border_height(border_height)
	m2d.set_floor_height(floor_height)
	m2d.set_floor_width(floor_width)
	m2d.set_wall_width(wall_width)
	m2d.set_has_ceiling(has_ceiling)
	m2d.set_ceiling_id(ceiling_id)
	
	m2d.build(grid, width, length)

	# TODO: pick random spot for finish orb

	var finishOrb = null
	if last:
		finishOrb = FinishBull.instance()
	else:
		finishOrb = FinishOrb.instance()
	finishOrb.name = "Finish"
	add_child(finishOrb)
	finishOrb.translate(cell_center((width-1)*(floor_width+wall_width)+0.5*floor_width, floor_height-1,
		(length-1)*(floor_width+wall_width)+0.5*floor_width))
	finishOrb.connect("sig_finished", self, "_on_finish")

func get_finish():
	return get_node("Finish")