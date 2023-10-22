extends Control
@onready var sound = $sound
@onready var tile_container = $HB/MC1/TileContainer
@onready var scorer: Scorer = $Scorer
@onready var moves_label = $HB/MC2/VBoxContainer/hb/MovesLabel
@onready var pairs_label = $HB/MC2/VBoxContainer/hb2/PairsLabel


@export var mem_tile_scene :PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moves_label.text = scorer.get_move_made_str()
	pairs_label.text = scorer.get_pair_made_str()


func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_game_exit_pressed.emit()

func add_memory_tile(ii_dict, frame_image):
	var new_tile = mem_tile_scene.instantiate()
	tile_container.add_child(new_tile)
	new_tile.setup(ii_dict, frame_image)

func on_level_selected(level_num):
	var level_selected = GameManager.get_level_selection(level_num)
	var frame_image = ImageManager.get_random_frame_image()
	
	tile_container.columns = level_selected.num_cols
	
	scorer.clear_new_game(level_selected.target_pair)
	
	for ii_dict in level_selected.image_list:
		add_memory_tile(ii_dict, frame_image)
