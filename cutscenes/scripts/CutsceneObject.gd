extends Node2D

export (bool) var autoplay
export (int,-80,20) var volume
export (Array, AudioStreamOGGVorbis) var streams

onready var audio_player = $AudioPlayer

var cutscene_is_playing = false

signal cutscene_completed
signal on_dialog_finished(stream_path)

func _ready() -> void:
	audio_player.volume_db = volume
	if autoplay:
		start()

func _input(event: InputEvent) -> void:
	if cutscene_is_playing:
		if Input.is_action_pressed("ui_select"):
			audio_player.stop()
			_play_dialog()

func start():
	cutscene_is_playing = true
	_play_dialog()
	

func _play_dialog():
	if !streams.empty():
		audio_player.stream = streams.pop_front()
		audio_player.play()
	else:
# warning-ignore:return_value_discarded
		emit_signal("cutscene_completed")

func _on_AudioPlayer_finished() -> void:
	emit_signal("on_dialog_finished",audio_player.stream.resource_path)
	_play_dialog()
	
