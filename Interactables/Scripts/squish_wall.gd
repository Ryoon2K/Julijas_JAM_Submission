class_name SquishWall extends Node2D

@export_group("Dependancies (Ignore)")
@export var at:AnimationTree

var state:bool = false

func change_state(b:bool):
	state = b
	if b: at.set("parameters/Transition/transition_request", "up")
	else: at.set("parameters/Transition/transition_request", "down")
