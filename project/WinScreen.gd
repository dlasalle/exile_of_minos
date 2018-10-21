extends Control

signal sig_done

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_points(points):
	$MarginContainer/VBoxContainer/Score/ScoreValue.text = "%05d" % points


func _on_FinishButton_pressed():
	emit_signal("sig_done")
