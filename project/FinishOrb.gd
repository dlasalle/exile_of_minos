# Copyright Dominique LaSalle <dominique@solidlake.com>, 2018-2020
extends Spatial

signal sig_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer3D.play()
	$AnimationPlayer.play("rotate_orb")


func _on_Area_body_entered(body):
	if body is GroundActor:
		emit_signal("sig_finished")
