extends Control

var levels_button_scene:PackedScene = preload("uid://coh5gnjtneyw0")

@onready var play_button: Button = %PlayButton
@onready var grid_container: GridContainer = %GridContainer
@onready var back_button: Button = %BackButton
@onready var panel: Panel = %Panel

signal play_pressed

func _ready() -> void:
	_get_levels()
	
	pass

func _get_levels() -> void:
	var path:String = "res://Scenes/Levels/"
	var levels_arr:= DirAccess.get_files_at(path)
	
	for level_path in levels_arr:
		var level_button:LevelSelectButton = levels_button_scene.instantiate()
		level_button.level_path = path+level_path
		
		var text:String = level_path.trim_suffix(".tscn")
		text = text.capitalize()
		level_button.text = text
		
		grid_container.add_child(level_button)
	
	pass

func _on_play_pressed() -> void:
	play_button.visible = false
	back_button.visible = true
	panel.visible = true
	pass # Replace with function body.

func _on_back_button_pressed() -> void:
	play_button.visible = true
	back_button.visible = false
	panel.visible = false
	pass # Replace with function body.
