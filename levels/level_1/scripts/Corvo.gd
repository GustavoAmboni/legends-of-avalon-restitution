extends Area2D

onready var corvo_path = get_parent()
onready var hoot = $Hoot
onready var wings = $WingBeat

func _ready() -> void:
	hoot.play()

# warning-ignore:unused_argument
func _on_Tween_tween_started(object: Object, key: NodePath) -> void:
	if object == corvo_path:
		if !wings.playing:
			hoot.stop()
			wings.play()


# warning-ignore:unused_argument
func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if object == corvo_path:
		if !hoot.playing:
			wings.stop()
			hoot.play()
