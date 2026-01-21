extends Node2D

@onready var cutscene_player: AnimationPlayer = $CutscenePlayer
@onready var start_button: Button = $StartButton

func _on_start_button_pressed() -> void:
	GameState.change_state(GameState.State.WAIT)
	start_button.visible = false
	cutscene_player.play("start_scene")


func _on_cutscene_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start_scene":
		visible = false
		GameState.change_state(GameState.State.MENU)
