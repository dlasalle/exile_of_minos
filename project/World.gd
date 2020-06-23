# Copyright Dominique LaSalle <dominique@solidlake.com>, 2018-2020
extends Spatial

signal sig_level_finished
signal sig_died

const Player = preload("res://Player.tscn")

var m_time = 0
var m_level = null
var m_player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new_game():
	if m_player != null:
		remove_child(m_player)
		m_player.queue_free()
	m_player = Player.instance()
	m_player.connect("sig_died", self, "_on_player_death")
	add_child(m_player)



func start_level(level):
	m_time = 0
	if m_level != null:
		remove_child(m_level)
	m_level = level
	m_level.connect("sig_finished", self, "_on_finish")
	m_player.global_transform.origin = Vector3(1, m_level.player_spawn_height, 1)
	m_player.set_velocity(Vector3(0,0,0))
	add_child(level)
	
	# make the player look at the finish
	var finish = level.get_finish()
	var finish_pos = finish.global_transform.origin
	var player_pos = m_player.global_transform.origin
	
	# calculate x angle
	var longitude = atan2(finish_pos.x - player_pos.x, finish_pos.z - player_pos.z)
	m_player.rotation.y = PI + longitude
	
	var latitude = atan2(finish_pos.y - player_pos.y,
		(Vector2(finish_pos.x, finish_pos.z) - Vector2(player_pos.x, player_pos.z)).length())
	
	m_player.set_look_angle(latitude)
	$StartPlayer.play()

func _physics_process(delta):
	m_time += delta
	m_player.set_time(m_time)

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_player_death():
	emit_signal("sig_died")

func _on_finish():
	emit_signal("sig_level_finished", m_time)
	$FinishPlayer.play()


