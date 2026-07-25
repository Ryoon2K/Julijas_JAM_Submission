extends CanvasLayer

@onready var play_button: Button = %PlayButton
@onready var grid_container: GridContainer = %GridContainer
@onready var back_button: Button = %BackButton

signal play_pressed

var levels

func _ready() -> void:
	
	
	pass

func _get_levels() -> void:
	
	pass

func _on_play_pressed() -> void:
	play_button.visible = false
	back_button.visible = true
	grid_container.visible = true
	pass # Replace with function body.

func _on_back_button_pressed() -> void:
	play_button.visible = true
	back_button.visible = false
	grid_container.visible = false
	pass # Replace with function body.
