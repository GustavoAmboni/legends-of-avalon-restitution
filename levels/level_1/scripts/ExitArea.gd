extends Area2D

onready var next_level = $NextLevelObject

func _on_ExitArea_body_entered(body: Node) -> void:
	if body == get_parent().get_node("Player"):
		next_level.go()
