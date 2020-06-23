# Copyright Dominique LaSalle <dominique@solidlake.com>, 2018-2020
extends Spatial

export (String) var type = "N/A"
export (int) var quantity = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Area_body_entered(body):
	if body.has_method("add_item"):
		body.add_item(type, quantity)
		queue_free()
		
