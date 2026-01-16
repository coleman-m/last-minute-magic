extends Control

const SNOWFLAKE_WAIT : float = 2.8

@onready var main_animation: AnimatedSprite2D = $MainAnimation

var timer : float = 0.0
var has_screen_transitioned : bool

func _on_minigame_start(game_name : String) -> void:
	visible = true
	timer = 0.0
	has_screen_transitioned = false
	main_animation.play(game_name)


func _process(delta: float) -> void:
	if main_animation.is_playing() and not has_screen_transitioned:
		timer += delta
		match main_animation.animation:
			"snowflake":
				if timer > SNOWFLAKE_WAIT:
					has_screen_transitioned = true
					EventBus.move_camera.emit(SelectionScreen.SNOWFLAKE_CAMER_LOCATION, 1)
					EventBus.show_the_snowflake.emit(false)


func _ready() -> void:
	EventBus.minigame_start.connect(_on_minigame_start)
	visible = false


func _on_main_animation_animation_finished() -> void:
	visible = false
	match main_animation.animation:
			"snowflake":
				GameState.change_state(GameState.State.SNOWFLAKE)
				EventBus.show_the_snowflake.emit(true)
	
