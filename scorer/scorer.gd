extends Node
class_name  Scorer

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer


var _selections: Array = []
var _target_pairs : int = 0
var _move_made: int = 0
var _pair_made: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_move_made_str():
	return str(_move_made)

func get_pair_made_str():
	return '%s / %s' % [_pair_made, _target_pairs]

func clear_new_game(target_pairs: int):
	_selections.clear()
	_pair_made = 0
	_move_made = 0
	_target_pairs = target_pairs
	


func selections_are_pair():
	return ( _selections[0].get_instance_id() !=  _selections[1].get_instance_id()
			and
		_selections[0].get_item_name() ==  _selections[1].get_item_name())

func kill_tile():
	for s in _selections:
		s.kill_on_success()
	_pair_made += 1
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)

func update_selection():
	reveal_timer.start()
	if selections_are_pair() == true:
		kill_tile()

func check_pair_made(tile: MemoryTile):
	tile.reveal(true)
	_selections.append(tile)
	if _selections.size() != 2:
		return
	
	SignalManager.on_selected_disable.emit()
	_move_made += 1
	update_selection()

func on_tile_selected(tile: MemoryTile):
	SoundManager.play_tile_click(sound)
	
	check_pair_made(tile)
	
func hide_selection():
	for s in _selections:
		s.reveal(false)

func check_game_over():
	if _pair_made >= _target_pairs:
		SignalManager.on_game_over.emit(_move_made)
	
func _on_reveal_timer_timeout():
	if selections_are_pair() == false:
		hide_selection()
	_selections.clear()
	check_game_over()
	SignalManager.on_selected_enable.emit()

func on_game_exit_pressed():
	reveal_timer.stop()
