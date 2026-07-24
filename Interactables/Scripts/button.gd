class_name button extends Node2D

@export var toggle_button:bool = false

@export_group("Export Nodes (ignore)")
@export var area:Area2D
@export var sprite_on:Sprite2D
@export var sprite_off:Sprite2D

var pressed:bool = false:
	set(new_val):
		if pressed == new_val: return
		pressed = new_val
		
		#TODO: Add more code here
		if new_val:
			sprite_off.visible = false
			sprite_on.visible = true
			
			if toggle_button: area.body_entered.disconnect(_change_state)
		else:
			sprite_off.visible = true
			sprite_on.visible = false
		
		button_pressed.emit(new_val)

signal button_pressed(bool)

func _ready() -> void:
	area.body_entered.connect(_change_state.bind(true))
	if !toggle_button:
		area.body_exited.connect(_change_state.bind(false))

func _change_state(_body:Node2D, on:bool): pressed = on
