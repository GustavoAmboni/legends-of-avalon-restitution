extends Path2D

export (int) var duration

onready var tween = $Tween
onready var corvo_path = $CorvoPath
onready var player = get_parent().get_node("Player")

func _on_FirstArea_body_entered(body: Node) -> void:
	tween.stop_all()
	if body == player:
		tween.interpolate_property(
			corvo_path,
			"unit_offset", 
			null,
			corvo_path.FIRST_POSITION,
			1, 
			tween.TRANS_LINEAR, 
			tween.EASE_IN_OUT
		)
		tween.start()


func _on_Second_Area_body_entered(body: Node) -> void:
	tween.stop_all()
	if body == player:
		tween.interpolate_property(
			corvo_path, 
			"unit_offset", 
			null,
			corvo_path.SECOND_POSITION, 
			duration,
			tween.TRANS_LINEAR, 
			tween.EASE_IN_OUT
		)
		tween.start()


func _on_ThirdArea_body_entered(body: Node) -> void:
	tween.stop_all()
	if body == player:
		tween.interpolate_property(
			corvo_path, 
			"unit_offset", 
			null,
			corvo_path.THIRD_POSITION, 
			6,
			tween.TRANS_LINEAR, 
			tween.EASE_IN_OUT
		)
		tween.start()
