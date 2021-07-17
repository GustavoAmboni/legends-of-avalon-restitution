extends Node2D

onready var next_level = $NextLevelObject
onready var cutscene = $CutsceneObject

func _ready() -> void:
	cutscene.start()

func _on_CutsceneObject_cutscene_completed() -> void:
	next_level.go()
