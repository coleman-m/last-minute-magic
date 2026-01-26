extends Camera2D

const AMBIENCE_SUBURBAN_NIGHT = preload("res://assets/sounds/Ambience_Suburban_Night by Eric Matyas www.soundimage.org.mp3")
const WHIMSICAL_POPSICLE = preload("res://assets/sounds/Whimsical-Popsicle by Eric Matyas www.soundimage.org.ogg")

@onready var screen_transition: Control = $ScreenTransition
@onready var background_sfx: AudioStreamPlayer2D = $BackgroundSfx

func _on_camera_move(new_position : Vector2, new_zoom : float) -> void:
	global_position = new_position
	zoom = Vector2.ONE * new_zoom


func _on_state_change() -> void:
	if GameState.current_state == GameState.State.MENU:
		background_sfx.stream = AMBIENCE_SUBURBAN_NIGHT
		background_sfx.play()
	if GameState.current_state == GameState.State.SNOWFLAKE:
		background_sfx.stream = WHIMSICAL_POPSICLE
		background_sfx.play()
	if GameState.current_state == GameState.State.TREE:
		background_sfx.stream = WHIMSICAL_POPSICLE
		background_sfx.play()


func _on_game_end() -> void:
	background_sfx.stop()


func _process(_delta: float) -> void:
	screen_transition.scale = Vector2.ONE * (1 / zoom.x)


func _ready() -> void:
	EventBus.move_camera.connect(_on_camera_move)
	EventBus.state_changed.connect(_on_state_change)
	EventBus.end_game.connect(_on_game_end)
