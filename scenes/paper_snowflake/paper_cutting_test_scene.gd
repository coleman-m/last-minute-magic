extends Node2D

var previous_mouse_position : Vector2
var mouse_positions : Array[Vector2]

func _draw():
	if mouse_positions.size() < 2: return
	if Input.is_action_pressed("mouse_down"):
		draw_polyline(mouse_positions, Color("478cbf"), 10)
	else:
		draw_colored_polygon(mouse_positions, Color("478cbf"))

func _ready() -> void:
	previous_mouse_position = get_global_mouse_position()
	

func _process(_delta):
	var current_mouse_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("mouse_down"):
		mouse_positions.clear()
		mouse_positions.append(current_mouse_position)
		previous_mouse_position = current_mouse_position
	
	elif Input.is_action_pressed("mouse_down") and (previous_mouse_position - current_mouse_position).length() > 1:
		mouse_positions.append(current_mouse_position)
		previous_mouse_position = current_mouse_position
		queue_redraw()
	
	elif Input.is_action_just_released("mouse_down"):
		queue_redraw()
		
