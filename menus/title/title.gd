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


func _process(_delta: float) -> void:
	if not cutscene_player.is_playing() or cutscene_player.current_animation == "title_screen": return
	if Input.is_action_just_pressed("mouse_down"):
		if cutscene_player.current_animation_position < 1.4667:
			cutscene_player.play_section("start_scene", 1.4667)
		elif cutscene_player.current_animation_position < 5.9667:
			cutscene_player.play_section("start_scene", 5.9667)
		elif cutscene_player.current_animation_position < 12.0667:
			cutscene_player.play_section("start_scene", 12.0667)
		elif cutscene_player.current_animation_position < 18.19:
			cutscene_player.play_section("start_scene", 18.19)
