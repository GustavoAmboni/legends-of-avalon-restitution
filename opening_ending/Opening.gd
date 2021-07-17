extends Node2D

onready var next_level = $NextLevelObject
onready var cutscene = $CutsceneObject

func _on_CutsceneObject_cutscene_completed() -> void:
	next_level.go()

func _on_Timer_timeout() -> void:
	cutscene.start()
