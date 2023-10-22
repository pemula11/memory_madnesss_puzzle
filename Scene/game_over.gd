extends Control

@onready var nine_patch_rect = $NinePatchRect
@onready var move_label = $NinePatchRect/MC/VB/HB/MoveLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_game_over.connect(on_game_over)



func on_game_over(moves: int):
	move_label.text = str(moves)
	show()

func _on_exit_button_pressed():
	hide()
	SignalManager.on_game_exit_pressed.emit()
