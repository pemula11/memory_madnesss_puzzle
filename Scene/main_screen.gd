extends Control

@export var level_button_scene: PackedScene
@onready var h_box_level = $VBoxContainer/HBoxLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()

func create_level_buttons(ln):
	var new_lb = level_button_scene.instantiate()
	h_box_level.add_child(new_lb)
	new_lb.set_level_number(ln)

func setup_grid():
	for level in GameManager.LEVELS:
		create_level_buttons(level)

