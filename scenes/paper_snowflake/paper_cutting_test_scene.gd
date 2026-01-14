extends Node2D

@onready var polygon_2d: Polygon2D = $Polygon2D

var polygon_points : Array[Vector2] = [Vector2(0,0),Vector2(1200,0),Vector2(sqrt(3) / 2 * 1200, -600)]
var polygon_position : Vector2 = Vector2(350, 800)
var previous_mouse_position : Vector2
var mouse_positions : Array[Vector2]
var polygons : Array[PackedVector2Array]

# find which points are inside / outside the area, return the indexs of the points inside the triangle
func sort_points_in() -> Array[int]:
	return []


func _draw():
	if mouse_positions.size() < 2: return
	if Input.is_action_pressed("mouse_down"):
		draw_polyline(mouse_positions, Color("478cbf"), 10)
	else:
		polygons.append_array(Geometry2D.merge_polygons(mouse_positions, PackedVector2Array([])))
	if not polygons.is_empty():	
		for poly in polygons:
			draw_colored_polygon(poly, Color("478cbf"))

func _ready() -> void:
	previous_mouse_position = get_global_mouse_position()
	polygon_2d.polygon = polygon_points
	polygon_2d.position = polygon_position


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
		
