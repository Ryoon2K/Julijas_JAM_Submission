extends Button

@onready var squish_wall: SquishWall = %SquishWall




func _on_pressed() -> void:
	squish_wall.change_state(!squish_wall.state)
	
