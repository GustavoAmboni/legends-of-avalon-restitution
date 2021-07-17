extends Node2D

export (bool) var autoquit = true

func _ready() -> void:
	if autoquit:
		quit()

func quit() -> void:
	get_tree().quit()
