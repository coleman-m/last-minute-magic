extends Control

const MENU_WAIT : float = 1
const SNOWFLAKE_WAIT : float = 2.8

@onready var main_animation: AnimatedSprite2D = $MainAnimation
@onready var snapshot_mask: Sprite2D = $SnapshotMask
@onready var snapshot_renderer: Sprite2D = $SnapshotMask/SnapshotRenderer

var scene_timer : float = 0.0
var has_screen_transitioned : bool

func move_snapshot(delta : float) -> void:
	snapshot_mask.position += Vector2.DOWN * delta * 750
	snapshot_renderer.position += Vector2.UP * delta * 750


func _on_minigame_start(game_name : String) -> void:
	visible = true
	scene_timer = 0.0
	has_screen_transitioned = false
	main_animation.play(game_name)


func _on_minigame_end() -> void:
	visible = true
	snapshot_mask.visible = true
	scene_timer = 0.0
	has_screen_transitioned = false
	main_animation.play("menu_return")
	snapshot_mask.position = Vector2(0, 0)
	snapshot_renderer.position = Vector2(0, 0)
	snapshot_renderer.texture = ImageTexture.create_from_image(get_viewport().get_texture().get_image())


func _process(delta: float) -> void:
	if main_animation.is_playing() and not has_screen_transitioned:
		scene_timer += delta
		match main_animation.animation:
			"snowflake":
				if scene_timer > SNOWFLAKE_WAIT:
					has_screen_transitioned = true
					EventBus.move_camera.emit(SelectionScreen.SNOWFLAKE_CAMER_LOCATION, 1)
					EventBus.show_the_snowflake.emit(false)
			"menu_return":
				if scene_timer > MENU_WAIT:
					has_screen_transitioned = true
					EventBus.move_camera.emit(SelectionScreen.SELECTION_CAMERA_LOCATION, 1)
	
	if main_animation.is_playing() and main_animation.animation == "menu_return" and has_screen_transitioned:
		move_snapshot(delta)


func _ready() -> void:
	EventBus.minigame_start.connect(_on_minigame_start)
	EventBus.minigame_end.connect(_on_minigame_end)
	visible = false
	snapshot_mask.visible = false


func _on_main_animation_animation_finished() -> void:
	visible = false
	match main_animation.animation:
			"snowflake":
				GameState.change_state(GameState.State.SNOWFLAKE)
				EventBus.show_the_snowflake.emit(true)
			"menu_return":
				GameState.change_state(GameState.State.MENU)
				snapshot_mask.visible = false
	
