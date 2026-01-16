extends Node

@warning_ignore_start("UNUSED_SIGNAL")
# emitted: game_state
# connected: 
signal state_changed

# emitted: selection_screen
# connected: main_camera
signal move_camera(new_position : Vector2, new_zoom : float)


signal minigame_start(game_name : String)


signal minigame_end


signal show_the_snowflake(do_show : bool)
