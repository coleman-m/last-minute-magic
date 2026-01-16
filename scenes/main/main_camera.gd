extends Camera2D

@onready var screen_transition: Control = $ScreenTransition

func _on_camera_move(new_position : Vector2, new_zoom : float) -> void:
	global_position = new_position
	zoom = Vector2.ONE * new_zoom


func _process(_delta: float) -> void:
	screen_transition.scale = Vector2.ONE * (1 / zoom.x)


func _ready() -> void:
	EventBus.move_camera.connect(_on_camera_move)
