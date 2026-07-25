extends StaticBody2D

func _open(b:bool) -> void:
	visible = !b
	collision_layer = !b
	
