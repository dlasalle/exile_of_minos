# Copyright Dominique LaSalle <dominique@solidlake.com>, 2018-2020
extends Node

const LEVEL_COMPLETION_POINTS = 25

var m_seed = 0
var m_points = 0
var m_current_level = 0

const LEVELS = [
	preload("res://levels/Desert.tscn"),
	preload("res://levels/Monument.tscn"),
	preload("res://levels/FloodedDungeon.tscn"),
	preload("res://levels/DarkDungeon.tscn")
]

func _ready():
	get_tree().paused = true
	$IntroScreen.show()

func _calc_points(time_left, time_limit):
	return clamp(time_limit-time_left, 0, time_limit) + LEVEL_COMPLETION_POINTS

func _start_level():
	var level = LEVELS[m_current_level].instance()
	if m_current_level + 1 == len(LEVELS):
		level.last = true
	level.generate(m_seed)
	
	$World.start_level(level)
	
	$IntroScreen.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_IntroScreen_sig_game_start(rseed):
	m_points = 0
	m_current_level = 0
	m_seed = rseed
	$World.new_game()
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
		$WinScreen.set_points(m_points)
		$WinScreen.visible = true
	$FinishPanel.visible = false


func _on_DeathPanel_sig_ok():
	$DeathPanel.visible = false
	reset()

func reset():
	get_tree().paused = true
	$IntroScreen.visible = true
	$IntroScreen.show()

func _on_WinScreen_sig_done():
	$WinScreen.visible = false
	reset()


