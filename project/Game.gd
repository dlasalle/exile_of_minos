extends Node

const LEVEL_COMPLETION_POINTS = 25

var m_seed = 0
var m_points = 0
var m_current_level = 0

const LEVELS = [
	#preload("res://levels/Desert.tscn"),
	#preload("res://levels/Monument.tscn"),
	preload("res://levels/FloodedDungeon.tscn")
]

func _ready():
	get_tree().paused = true
	$GamePanel.show()

func _calc_points(time_left, time_limit):
	return clamp(time_limit-time_left, 0, time_limit) + LEVEL_COMPLETION_POINTS

func _start_level():
	var level = LEVELS[m_current_level].instance()
	level.generate(m_seed)
	
	$World.start_level(level)
	
	$GamePanel.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_GamePanel_sig_start_game(rseed):
	m_points = 0
	m_current_level = 0
	m_seed = rseed
	_start_level()


func _on_World_sig_died():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	$DeathPanel.set_points(m_points)
	$DeathPanel.visible = true


func _on_World_sig_level_finished(time):
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var new_points = _calc_points(time, 180)
	m_points += new_points
	$FinishPanel.set_time(time)
	$FinishPanel.set_points(new_points)
	$FinishPanel.set_total_points(m_points)
	$FinishPanel.visible = true


func _on_FinishPanel_sig_next():
	m_current_level += 1
	if m_current_level < len(LEVELS):
		m_seed += 1
		_start_level()
	else:
		# they win
		pass
	$FinishPanel.visible = false


func _on_DeathPanel_sig_ok():
	$DeathPanel.visible = false
	get_tree().paused = true
	$GamePanel.visible = true
	$GamePanel.show()
