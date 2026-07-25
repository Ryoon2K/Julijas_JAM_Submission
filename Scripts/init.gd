extends Node2D

var arrow = load("res://Assets/Cursor/cursor.svg")
var grab = load("res://Assets/Cursor/grab.svg")
var hand = load("res://Assets/Cursor/hand.svg")
var pointer = load("res://Assets/Cursor/pointer.svg")

func _ready() -> void:
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW, Vector2(4,4))
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND, Vector2(10,4))
	Input.set_custom_mouse_cursor(hand, Input.CURSOR_MOVE, Vector2(16,16))
	Input.set_custom_mouse_cursor(grab, Input.CURSOR_DRAG, Vector2(16,16))
