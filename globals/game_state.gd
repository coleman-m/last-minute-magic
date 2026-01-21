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

func change_state(new_state : State) -> void:
	current_state = new_state
	EventBus.state_changed.emit()
