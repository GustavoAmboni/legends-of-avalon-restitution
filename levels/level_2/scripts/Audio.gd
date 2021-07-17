extends Node2D

onready var inicio = $Inicio
onready var movement = $Movement

func _ready() -> void:
	movement.play()

func _on_Movement_finished() -> void:
	inicio.play()
