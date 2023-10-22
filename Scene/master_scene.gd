extends CanvasLayer

@onready var main_screen = $MainScreen
@onready var game_screen = $GameScreen
@onready var sound = $sound


# Called when the node enters the scene tree for the first time.
func _ready():
	on_game_exit_pressed()
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)
	SignalManager.on_level_selected.connect(on_level_selected)

func show_game(s: bool):
	game_screen.visible = s
	main_screen.visible = !s

func on_game_exit_pressed():
	show_game(false)
	GameManager.clear_node_of_group(GameManager.GROUP_TILE)
	SoundManager.play_sound(sound, SoundManager.SOUND_MAIN_MENU)
	
func on_level_selected(level: int):
	show_game(true)
	
	SoundManager.play_sound(sound, SoundManager.SOUND_IN_GAME)
