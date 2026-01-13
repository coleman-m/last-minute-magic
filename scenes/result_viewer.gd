extends SubViewport

func _process(_delta: float) -> void:
	world_2d = get_tree().root.get_viewport().world_2d
