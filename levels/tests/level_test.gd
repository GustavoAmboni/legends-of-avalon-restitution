extends Node2D


const MAX_LINE_DIRECTION_LENGHT : float = 150.0

var initial_position : Vector2 = Vector2.ZERO
var final_position : Vector2 = Vector2.ZERO
var line_body : Vector2 = Vector2.ZERO
var line_direction : Vector2 = Vector2.ZERO
var flag : bool = false

func _input(event : InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			initial_position = event.position
			final_position = event.position
			line_direction = Vector2.ZERO
			flag = false
		elif not event.is_pressed() and line_body.length() < MAX_LINE_DIRECTION_LENGHT:
			flag = true
		elif not event.is_pressed() and not flag:
			print("sucesso!")
	if event is InputEventScreenDrag and not flag:
		final_position = event.position
		line_body = initial_position - final_position
		if line_body.length() < MAX_LINE_DIRECTION_LENGHT:
			if line_direction == Vector2.ZERO:
				line_direction = calc_direction(line_body)
		else:
			if line_direction != calc_direction(line_body) or line_direction == Vector2.ZERO:
				flag = true
	update()


func calc_direction(gesture : Vector2) -> Vector2:
	match stepify(gesture.angle(), PI/4):
		0.0: 
			return Vector2.LEFT
		PI, -PI: 
			return Vector2.RIGHT
		PI/2:
			return Vector2.UP
		-(PI/2): 
			return Vector2.DOWN
		_:
			return Vector2.ZERO

func _draw() -> void:
	draw_line(initial_position, final_position, (Color.blue if not flag else Color.red), 10)
	
	
