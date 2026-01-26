class_name SelectionScreen
extends Node2D

const SELECTION_CAMERA_LOCATION : Vector2 = Vector2(960, 540)
const TREE_EDIT_CAMERA_LOCATION : Vector2 = Vector2(-2400, 540)
const SNOWFLAKE_CAMER_LOCATION : Vector2 = Vector2(4800, 540)

func _on_tree_button_pressed() -> void:
	if GameState.current_state != GameState.State.MENU: return
	GameState.change_state(GameState.State.WAIT)
	EventBus.minigame_start.emit("tree")


func _on_snowflake_button_pressed() -> void:
	if GameState.current_state != GameState.State.MENU: return
	GameState.change_state(GameState.State.WAIT)
	EventBus.minigame_start.emit("snowflake")


func _on_end_night_button_pressed() -> void:
	if GameState.current_state != GameState.State.MENU: return
	GameState.change_state(GameState.State.WAIT)
	EventBus.end_game.emit()
