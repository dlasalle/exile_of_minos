extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in $Invectory/HBoxContainer.get_children():
		item.update_quantity(item.quantity)

func set_time(time):
	var hours = int(time / (60*60))
	var minutes = int((time/60) - (hours*60))
	var seconds = int(time - (((hours*60)+minutes)*60))
	var fracs = int(10*(time - int(time)))
	$Timer.text = "%02d:%02d:%02d.%01d" % [hours, minutes, seconds, fracs]

func update_quantity(item_name, q):
	var node = $Invectory/HBoxContainer.get_node(item_name)
	node.update_quantity(q)
	
	