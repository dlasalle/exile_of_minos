# Copyright Dominique LaSalle <dominique@solidlake.com>, 2018-2020
extends PanelContainer

signal sig_next

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_points(points):
	$VBoxContainer/GridContainer/PointsValue.text = "%05d" % points

func set_time(time):
	var hours = int(time / (60*60))
	var minutes = int((time/60) - (hours*60))
	var seconds = int(time - (((hours*60)+minutes)*60))
	$VBoxContainer/GridContainer/TimeValue.text = "%02d:%02d:%02d" % [hours, minutes, seconds]

func set_total_points(points):
	$VBoxContainer/GridContainer/TotalPointsValue.text = "%05d" % points

func _on_NextButton_pressed():
	emit_signal("sig_next")
