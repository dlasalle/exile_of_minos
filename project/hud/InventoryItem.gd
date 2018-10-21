extends Control

export (int) var quantity = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_quantity(q):
	quantity = q
	$VBoxContainer/HBoxContainer/Quantity.text = "%03d" % quantity
