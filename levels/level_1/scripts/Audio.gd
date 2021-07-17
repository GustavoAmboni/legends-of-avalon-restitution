extends Node2D

onready var inicio = $Inicio
onready var achievement = $Achievement
onready var campfire_near = $CampfireNear
onready var campfire_near_timer = $CampfireNearTimer

var achievements_enable = false
var achv_movement = false
var achv_rotation_left = false
var achv_rotation_right = false
var campfire_tip = true

func _ready() -> void:
	inicio.play()
	achievements_enable = true

func _on_Player_movement() -> void:
	if achievements_enable:
		if !achv_movement:
			achievement.play()
			achv_movement = true

func _on_Player_rotation_left() -> void:
	if achievements_enable:
		if !achv_rotation_left:
			achievement.play()
			achv_rotation_left = true

func _on_Player_rotation_right() -> void:
	if achievements_enable:
		if !achv_rotation_right:
			achievement.play()
			achv_rotation_right = true

func _on_ThirdArea_body_entered(body: Node) -> void:
	if body == get_parent().get_node("Player"):
		if campfire_tip:
			campfire_near.play()
			campfire_tip = false
			campfire_near_timer.start()

func _on_CampfireNearTimer_timeout() -> void:
	campfire_tip = true
