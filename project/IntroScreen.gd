extends Control

signal sig_game_start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GamePanel_sig_start_game(rseed):
	emit_signal("sig_game_start", rseed)

func show():
	$GamePanel.show()