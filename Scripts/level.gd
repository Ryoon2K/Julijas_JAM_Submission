extends Node2D

@export var self_UID:String
@export var next_level_UID:String

@onready var game_over: Control = %GameOver

@onready var level_complete: Control = %LevelComplete
@onready var win_label: Label = %WinLabel
@onready var next_level_button: Button = %NextLevel


func _on_restart_button_pressed() -> void:
	MainScene.inst.change_scene(self_UID)

func _on_menu_button_pressed() -> void:
	MainScene.inst.change_scene("uid://ckrm3moohpf2h")

func _on_next_level_pressed() -> void:
	MainScene.inst.change_scene(next_level_UID)

func _on_cheese_cheese_got() -> void:
	if next_level_UID.is_empty():
		win_label.text = "CONGRATULATIONS!!!\nYOU ATE ALL THE CHEESE!!!\nThank you for playing!"
		win_label.set("theme_override_font_sizes/font_size",52)
		next_level_button.visible = false
	else:
		win_label.text = "You ate the cheese!"
		win_label.set("theme_override_font_sizes/font_size",76)
		next_level_button.visible = true
	
	level_complete.visible = true
	

func _on_remy_died() -> void:
	game_over.visible = true
	
