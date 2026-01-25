extends Node2D

@onready var sleeping: Node2D = $Sleeping
@onready var celebrating: Node2D = $Celebrating
@onready var credits: Node2D = $Credits
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var has_slept : bool = false
var has_celebrated : bool = false
var game_complete : bool = false

func _on_end_game() -> void:
	sleeping.visible = true
	animation_player.play("sleeping")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "sleeping":
		if not has_slept:
			celebrating.visible = true
			has_slept = true
			animation_player.play_backwards("sleeping")
		else:
			animation_player.play("celebrating")
	elif anim_name == "celebrating":
		credits.visible = true
		has_celebrated = true
	elif anim_name == "credits":
		game_complete = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_down") and has_celebrated and not game_complete:
		animation_player.play("credits")


func _ready() -> void:
	EventBus.end_game.connect(_on_end_game)
	sleeping.visible = false
	celebrating.visible = false
	credits.visible = false
