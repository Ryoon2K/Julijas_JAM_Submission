extends Node2D

@export var ap:AnimationPlayer

signal cheese_got

func _ready() -> void:
	ap.play("spin")


func _on_area_2d_body_entered(body: Node2D) -> void:
	cheese_got.emit()
	queue_free()
	pass # Replace with function body.
