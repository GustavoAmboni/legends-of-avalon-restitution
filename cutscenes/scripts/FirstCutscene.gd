extends Node2D

onready var guitar = $Guitar
onready var cutscene = $CutsceneObject
onready var next_level = $NextLevelObject

var once = false

func _ready() -> void:
	var tween = Tween.new()
	add_child(tween)
	guitar.play()
	tween.interpolate_property(
		guitar,
		"volume_db",
		null,
		5,
		6,
		tween.TRANS_LINEAR,
		tween.EASE_IN_OUT
	)
	tween.start()
	
# warning-ignore:unused_argument
func _process(delta: float) -> void:
	if !once:
		if guitar.get_playback_position() > 25.0:
			var tween = Tween.new()
			add_child(tween)
			tween.connect("tween_completed", self, "_on_low_guitar_completed")
			tween.interpolate_property(
				guitar,
				"volume_db",
				null,
				-15,
				6,
				tween.TRANS_LINEAR,
				tween.EASE_IN_OUT
			)
			tween.start()
			once = true

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_low_guitar_completed(object: Object, key: NodePath) -> void:
	cutscene.start()

func _on_CutsceneObject_cutscene_completed() -> void:
	var tween = Tween.new()
	add_child(tween)
	tween.connect("tween_completed", self, "_on_increase_guitar_completed")
	tween.interpolate_property(
		guitar,
		"volume_db",
		null,
		0,
		8,
		tween.TRANS_LINEAR,
		tween.EASE_IN_OUT
	)
	tween.start()

func _on_increase_guitar_completed(object: Object, key: NodePath) -> void:
	next_level.go()

func _on_CutsceneObject_on_dialog_finished(stream) -> void:
	var play_sword = "res://cutscenes/first_cutscene/audio/yuri_fala_3.ogg"
	match(stream):
		
		play_sword:
			pass
		
