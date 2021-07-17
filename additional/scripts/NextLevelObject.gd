extends Node2D

export (String, FILE, "*.tscn") var next_scene

func go() -> void:
	if next_scene:
# warning-ignore:return_value_discarded
		get_tree().change_scene(next_scene)
