extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


func _on_GamePanel_sig_start_game(rseed):
	$World.start_game(rseed)
	$GamePanel.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_World_sig_died():
	pass # Replace with function body.


func _on_World_sig_level_finished(time):
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$FinishPanel.set_time(time)
	$FinishPanel.visible = true