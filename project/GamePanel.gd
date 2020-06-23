# Copyright Dominique LaSalle <dominique@solidlake.com>, 2018-2020
extends PanelContainer


signal sig_start_game

func timestamp():
	return OS.get_unix_time()

# Called when the node enters the scene tree for the first time.
func _ready():
	show()

func show():
	var rseed = timestamp() % int($VBoxContainer/HBoxContainer/Seed.max_value)
	$VBoxContainer/HBoxContainer/Seed.value = rseed

func _on_StartButton_pressed():
	var rseed = int($VBoxContainer/HBoxContainer/Seed.value)
	emit_signal("sig_start_game", rseed)
