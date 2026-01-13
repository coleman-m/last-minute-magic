class_name SelectionScreen
extends Node2D

const SELECTION_CAMERA_LOCATION : Vector2 = Vector2(960, 540)
const TREE_EDIT_CAMERA_LOCATION : Vector2 = Vector2(3125, 675)

func _on_tree_button_pressed() -> void:
	GameState.change_state(GameState.State.TREE)
	EventBus.move_camera.emit(TREE_EDIT_CAMERA_LOCATION, 2)
