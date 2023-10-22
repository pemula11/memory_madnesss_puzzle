extends Node

const FRAME_IMAGES: Array = [
	preload("res://assets/frames/blue_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
	preload("res://assets/frames/red_frame.png"),
	preload("res://assets/frames/green_frame.png"),
]
var _item_images: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_item_images()

func add_file_to_list(fn:String, path:String):
	var full_path = path + "/" + fn
	var li_dict = {
		"item_name": fn.rstrip(".png"),
		"item_texture": load(full_path)
	}
	_item_images.append(li_dict)

func load_item_images():
	
	var path = "res://assets/glitch"
	var dir = DirAccess.open(path)
	
	if not dir:
		print("error path: ", path)
		return
		
	var file_name = dir.get_files()
	
	
	for fn in file_name:
		if ".import" not in fn:
			add_file_to_list(fn, path)
	
	
	
func get_random_item_image() ->Dictionary:
	return _item_images.pick_random()
	
func get_item(index: int):
	return _item_images[index]
	
func get_random_frame_image() -> CompressedTexture2D:
	return FRAME_IMAGES.pick_random()

func shuffle_images():
	_item_images.shuffle()
