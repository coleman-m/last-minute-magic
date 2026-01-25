extends Node2D

const ORNAMENT_SCENE : PackedScene = preload("res://scenes/tree/ornament.tscn")

func _process(_delta: float) -> void:
	if GameState.current_state != GameState.State.TREE: return
	
	if Input.is_action_just_pressed("mouse_down"):
		var new_ornament : Sprite2D = ORNAMENT_SCENE.instantiate()
		add_child(new_ornament)
		new_ornament.global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("ui_down"):
		GameState.change_state(GameState.State.WAIT)
		EventBus.minigame_end.emit()


func _on_menu_button_pressed() -> void:
	if GameState.current_state != GameState.State.TREE: return
	GameState.change_state(GameState.State.WAIT)
	EventBus.minigame_end.emit()
