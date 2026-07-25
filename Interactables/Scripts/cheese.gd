extends Node2D

@export var ap:AnimationPlayer

func _ready() -> void:
	ap.play("spin")
