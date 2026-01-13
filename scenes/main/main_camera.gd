extends Camera2D

func _on_camera_move(new_position : Vector2, new_zoom : float) -> void:
	global_position = new_position
	zoom = Vector2.ONE * new_zoom


func _ready() -> void:
	EventBus.move_camera.connect(_on_camera_move)
