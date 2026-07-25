class_name SquishWall extends Node2D

@export_group("Dependancies (Ignore)")
@export var at:AnimationTree

func change_state(b:bool):
	if b: at.set("parameters/Transition/transition_request", "up")
	else: at.set("parameters/Transition/transition_request", "down")
