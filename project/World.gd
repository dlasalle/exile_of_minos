extends Spatial

signal sig_level_finished
signal sig_died

const Player = preload("res://Player.tscn")

var m_time = 0
var m_level = null
var m_player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	m_player = Player.instance()
	add_child(m_player)



func start_level(level):
	m_time = 0
	if m_level != null:
		remove_child(m_level)
	m_level = level
	m_level.connect("sig_finished", self, "_on_finish")
	m_player.global_transform.origin = Vector3(0.5, 40, 0.5)
	add_child(level)

func _physics_process(delta):
	m_time += delta
	var hours = int(m_time / (60*60))
	var minutes = int((m_time/60) - (hours*60))
	var seconds = int(m_time - (((hours*60)+minutes)*60))
	var fracs = int(10*(m_time - int(m_time)))
	$TimerValue.text = "%02d:%02d:%02d.%01d" % [hours, minutes, seconds, fracs]

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _on_finish():
	emit_signal("sig_level_finished", m_time)


