extends Node

enum State {
	MENU,
	TREE,
	SNOWFLAKE,
	PRESENT,
	WAIT
}

var current_state : State = State.MENU

func change_state(new_state : State) -> void:
	current_state = new_state
	EventBus.state_changed.emit()
