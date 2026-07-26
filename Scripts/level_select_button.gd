class_name LevelSelectButton extends Button

var level_path:String

func _on_pressed() -> void:
	
	MainScene.inst.change_scene(level_path)
	
	pass # Replace with function body.
