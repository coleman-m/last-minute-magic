extends Node2D

const ORNAMENT_SCENE : PackedScene = preload("res://scenes/tree/ornament.tscn")
enum TreeState {
	PREGAME,
	LIGHTS,
	ORNAMENTS,
	STAR
}
var mouse_in_tree_mask : bool = false
var curr_tree_state : TreeState = TreeState.PREGAME


func _process(_delta: float) -> void:
	if GameState.current_state != GameState.State.TREE: return
	if not mouse_in_tree_mask: return
	if Input.is_action_just_pressed("mouse_down"):
		if curr_tree_state == TreeState.PREGAME: return
		if curr_tree_state == TreeState.ORNAMENTS:
			var new_ornament : Sprite2D = ORNAMENT_SCENE.instantiate()
			add_child(new_ornament)
			new_ornament.global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("ui_cancel"):
		GameState.change_state(GameState.State.WAIT)
		EventBus.minigame_end.emit()


func _on_menu_button_pressed() -> void:
	if GameState.current_state != GameState.State.TREE: return
	GameState.change_state(GameState.State.WAIT)
	EventBus.minigame_end.emit()


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	curr_tree_state = TreeState.ORNAMENTS


func _on_tree_mask_mouse_entered() -> void:
	mouse_in_tree_mask = true


func _on_tree_mask_mouse_exited() -> void:
	mouse_in_tree_mask = false
