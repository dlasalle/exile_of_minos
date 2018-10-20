extends Spatial

signal sig_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer3D.play()
	$AnimationPlayer.play("rotate_orb")


func _on_Area_body_entered(body):
	if body is Actor:
		emit_signal("sig_finished")
