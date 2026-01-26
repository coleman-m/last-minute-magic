extends Node

enum State {
	TITLE,
	MENU,
	TREE,
	SNOWFLAKE,
	PRESENT,
	WAIT
}

var current_state : State = State.TITLE
var has_snowflaked : bool = false
var has_treed : bool = false


func change_state(new_state : State) -> void:
	current_state = new_state
	EventBus.state_changed.emit()
	if new_state == State.SNOWFLAKE:
		has_snowflaked = true
	if new_state == State.TREE:
		has_treed = true
