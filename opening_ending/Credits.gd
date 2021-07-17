extends Node2D

onready var next_level = $NextLevelObject
onready var cutscene = $CutsceneObject
onready var sair_timer = $SairTimer
onready var sair_audio = $SairAudio

var can_sair = false

func _on_CutsceneObject_cutscene_completed() -> void:
	can_sair = true
	sair_audio.play()
	sair_timer.start()

func _on_CutsceneTimer_timeout() -> void:
	cutscene.start()

func _on_SairTimer_timeout() -> void:
	sair_audio.play()
	
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if can_sair:
			next_level.go()
