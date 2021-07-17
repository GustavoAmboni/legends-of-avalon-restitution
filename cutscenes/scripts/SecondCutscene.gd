extends Node2D

onready var cutscene = $CutsceneObject
onready var next_level = $NextLevelObject

func _ready() -> void:
	cutscene.start()

func _on_CutsceneObject_cutscene_completed() -> void:
	next_level.go()
