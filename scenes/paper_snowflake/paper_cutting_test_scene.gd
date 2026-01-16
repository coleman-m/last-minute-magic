extends Node2D

const LINE02M : float = 1 / sqrt(3)
const LINE02B : float = -800 - 350 / sqrt(3)
const LINE21M : float = -1 / (2 - sqrt(3))
const LINE21B : float = -800 + 1550 / (2 - sqrt(3))

@onready var polygon_2d: Polygon2D = $Polygon2D

var polygon_points : Array[Vector2] = [Vector2(0,0),Vector2(1200,0),Vector2(sqrt(3) / 2 * 1200, -600)]
var polygon_points_y_inverted_and_transformed : Array[Vector2]
var polygon_position : Vector2 = Vector2(350, 800)
var previous_mouse_position : Vector2
var mouse_positions : Array[Vector2]
var polygons : Array[PackedVector2Array]

func update_point_if_outside(point : Vector2) -> Vector2:
	# y values are being flipped alot to make the math nicer for me
	point = Vector2(point.x, -point.y)
	# below 0->1 line
	if point.y < -800:
		point = Geometry2D.get_closest_point_to_segment(point, polygon_points_y_inverted_and_transformed[0], polygon_points_y_inverted_and_transformed[1])
	# above 0->2 line
	if point.y > LINE02M * point.x + LINE02B:
		point = Geometry2D.get_closest_point_to_segment(point, polygon_points_y_inverted_and_transformed[0], polygon_points_y_inverted_and_transformed[2])
	# above 2->1 line
	if point.y > LINE21M * point.x + LINE21B:
		point = Geometry2D.get_closest_point_to_segment(point, polygon_points_y_inverted_and_transformed[2], polygon_points_y_inverted_and_transformed[1])
	
	point = Vector2(point.x, -point.y)
	return point


func _on_show_snowflake(do_show : bool) -> void:
	polygon_2d.visible = do_show


func _draw():
	if mouse_positions.size() < 2: 
		if not polygons.is_empty():	
			for poly in polygons:
				if Geometry2D.triangulate_polygon(poly).size() > 0:
					draw_colored_polygon(poly, Color("458282"))
		return
	var do_draw_line : bool = false
	if Input.is_action_pressed("mouse_down"):
		do_draw_line = true
	else:
		for i in range(mouse_positions.size()):
			mouse_positions[i] = update_point_if_outside(mouse_positions[i])
		if mouse_positions.size() > 3:
			polygons.append_array(Geometry2D.merge_polygons(mouse_positions, PackedVector2Array([])))
	if not polygons.is_empty():	
		for poly in polygons:
			if Geometry2D.triangulate_polygon(poly).size() > 0:
				draw_colored_polygon(poly, Color("458282"))
	if do_draw_line:
		draw_polyline(mouse_positions, Color("AAAAAA"), 10)

func _ready() -> void:
	EventBus.show_the_snowflake.connect(_on_show_snowflake)
	previous_mouse_position = get_local_mouse_position()
	polygon_2d.polygon = polygon_points
	polygon_2d.position = polygon_position
	
	for point in polygon_points:
		polygon_points_y_inverted_and_transformed.append(Vector2(point.x + polygon_position.x, -point.y - polygon_position.y))


func _process(_delta):
	if GameState.current_state != GameState.State.SNOWFLAKE: return
	var current_mouse_position = get_local_mouse_position()
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
		
	elif Input.is_action_just_pressed("ui_down"):
		GameState.change_state(GameState.State.MENU)
		EventBus.move_camera.emit(SelectionScreen.SELECTION_CAMERA_LOCATION, 1)
		
