class_name MainScene extends Node

static var inst:MainScene

@onready var loading_screen: Control = %LoadingScreen
@onready var game_layer: Node = %GameLayer


var arrow = load("res://Assets/Cursor/cursor.svg")
var grab = load("res://Assets/Cursor/grab.svg")
var hand = load("res://Assets/Cursor/hand.svg")
var pointer = load("res://Assets/Cursor/pointer.svg")

var game_scene:Node


func _enter_tree() -> void:
	inst = self

func _ready() -> void:
	game_scene = %MainMenu
	
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW, Vector2(4,4))
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND, Vector2(10,4))
	Input.set_custom_mouse_cursor(hand, Input.CURSOR_MOVE, Vector2(16,16))
	Input.set_custom_mouse_cursor(grab, Input.CURSOR_DRAG, Vector2(16,16))


func change_scene(UID:String) -> void:
	loading_screen.play()
	await loading_screen.tween_finished
	var err:Error = ResourceLoader.load_threaded_request(UID)
	
	game_scene.queue_free()
	
	while ResourceLoader.load_threaded_get_status(UID) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame
	
	var scene_res:PackedScene
	if ResourceLoader.load_threaded_get_status(UID) == ResourceLoader.THREAD_LOAD_LOADED:
		scene_res = ResourceLoader.load_threaded_get(UID)
	
	var scene = scene_res.instantiate()
	game_scene = scene
	game_layer.add_child(scene)
	
	loading_screen.stop()
	
