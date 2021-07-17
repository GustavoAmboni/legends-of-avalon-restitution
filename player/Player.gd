extends KinematicBody2D

export (int) var speed
export (int) var rotation_speed

const ROTATION_LEFT = -1
const ROTATION_RIGHT = 1

signal rotation_left
signal rotation_right
signal movement

onready var collision_ray1 = $CollisionRay
onready var collision_ray2 = $CollisionRay2

var velocity: Vector2 = Vector2.ZERO
var rotation_direction = 0
var colliding = false

var footsteps_sound: AudioStreamPlayer2D
var collision_sound: AudioStreamPlayer2D
var rotation_sound: AudioStreamPlayer2D
var collision_tip_sound: AudioStreamPlayer2D

func _ready() -> void:
		footsteps_sound = get_node_or_null("Footsteps")
		collision_sound = get_node_or_null("Collision")
		rotation_sound = get_node_or_null("Rotation")
		collision_tip_sound = get_node_or_null("CollisionTip")

func _movement_handler(delta : float):
	var button_left_pressed = Input.is_action_pressed("ui_left")
	var button_right_pressed = Input.is_action_pressed("ui_right")
	var just_collide : bool = false
	
	rotation += rotation_speed * rotation_direction * delta
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 1)
	
	just_collide = is_on_wall()
	
	rotation_direction = 0
	velocity = Vector2.ZERO
	
	if button_left_pressed and !button_right_pressed:
		rotation_direction += ROTATION_LEFT
		emit_signal("rotation_left")
		_sound_handler("rotation_left")
		
	if button_right_pressed and !button_left_pressed:
		rotation_direction += ROTATION_RIGHT
		emit_signal("rotation_right")
		_sound_handler("rotation_right")
		
	if button_right_pressed and button_left_pressed:
		rotation_direction = 0
		velocity = Vector2(speed, 0).rotated(rotation)
			
		#Player just collided
		if just_collide and !colliding:
			colliding = true
			_sound_handler("stop")
			_sound_handler("collide")
		
		#Player is not colliding
		elif !just_collide:
			colliding = false
			_sound_handler("walk")
			emit_signal("movement")
	
		#Player is colliding
		elif just_collide and colliding:
			_sound_handler("stop")
			if collision_ray1.is_colliding() or collision_ray2.is_colliding():
				velocity = Vector2.ZERO
				_sound_handler("collide")
		
	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		_sound_handler("stop")
		_sound_handler("collide_tip_stop")

func _sound_handler(action: String):
	match(action):
		"walk": 
			if rotation_sound:
					rotation_sound.stop()
			if footsteps_sound:
				if footsteps_sound.volume_db < 0:
					var animation = Tween.new() 
					add_child(animation)
					animation.interpolate_property(
						footsteps_sound, 
						"volume_db", 
						null,
						0,
						0.2,
						Tween.TRANS_LINEAR,
						Tween.EASE_OUT
					)
					animation.start()
		"stop":
			if rotation_sound:
				if rotation_sound.playing:
					rotation_sound.stop()
			if footsteps_sound:
				if footsteps_sound.volume_db != -80:
					var animation = Tween.new()
					add_child(animation)
					animation.interpolate_property(
						footsteps_sound, 
						"volume_db", 
						null,
						-80,
						2,
						Tween.TRANS_LINEAR,
						Tween.EASE_OUT
					)
					animation.start()
		"collide":
			if collision_sound:
				if !collision_sound.playing:
					collision_sound.play()
					
		"rotation_left":
			if rotation_sound:
				if rotation_sound.bus == "Effect_rotation":
					if !rotation_sound.playing:
						AudioServer.get_bus_effect(AudioServer.get_bus_index("Effect_rotation"), 0).pan = -1
						rotation_sound.play()
		"rotation_right":
			if rotation_sound:
				if rotation_sound.bus == "Effect_rotation":
					if !rotation_sound.playing:
						AudioServer.get_bus_effect(AudioServer.get_bus_index("Effect_rotation"), 0).pan = 1
						rotation_sound.play()

func _physics_process(delta: float) -> void:
	_movement_handler(delta)
