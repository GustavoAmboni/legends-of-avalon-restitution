extends Area2D

var played = false

export (AudioStream) var audio 

onready var audio_player = $AudioPlayer

func _ready() -> void:
	
	if audio:
		audio_player.stream = audio

func _on_InteractiveArea_body_entered(body: Node) -> void:
	if body.get_class() == "KinematicBody2D":
		if audio_player.stream:
			if !played:
				audio_player.play()
				played = true
