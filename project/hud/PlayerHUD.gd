extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in $Invectory/HBoxContainer.get_children():
		item.update_quantity(item.quantity)

func update_quantity(item_name, q):
	var node = $Invectory/HBoxContainer.get_node(item_name)
	node.update_quantity(q)
	
	