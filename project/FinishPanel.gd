extends PanelContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_points(points):
	$VBoxContainer/GridContainer/PointsValue.text = "%05d" % points

func set_time(time):
	var hours = int(time / (60*60))
	var minutes = int((time/60) - (hours*60))
	var seconds = time - (((hours*60)+minutes)*60)
	$VBoxContainer/GridContainer/TimeValue.text = "%02d:%02d:%02.1f" % [hours, minutes, seconds]

	set_points(clamp(180-time, 0, 180))
