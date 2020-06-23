# Copyright Dominique LaSalle <dominique@solidlake.com>, 2018-2020
extends PanelContainer

signal sig_ok

func _ready():
	pass # Replace with function body.

func set_points(points):
	$VBoxContainer/VBoxContainer/PointsValue.text = "%05d" % points

func _on_OkButton_pressed():
	emit_signal("sig_ok")
