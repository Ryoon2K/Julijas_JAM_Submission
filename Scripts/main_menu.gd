extends Control

var levels_button_scene:PackedScene = preload("uid://coh5gnjtneyw0")

@onready var play_button: Button = %PlayButton
@onready var grid_container: GridContainer = %GridContainer
@onready var back_button: Button = %BackButton
@onready var panel: Panel = %Panel

@onready var remy: Remy = %remy
@onready var cheese: Node2D = %Cheese
@onready var bingbong: Node2D = %bingbong


func _ready() -> void:
	_get_levels()
	
	for child:SoftBody2D.SoftBodyChild in bingbong.soft_body_2d.get_rigid_bodies():
		var rigid:RigidBody2D = child.rigidbody
		rigid.freeze = true
	
	get_tree().create_timer(2.5).timeout.connect(_launch_rat)
	get_tree().create_timer(8).timeout.connect(_unfreeze_bb)
	
	pass

func _unfreeze_bb() -> void:
	for child:SoftBody2D.SoftBodyChild in bingbong.soft_body_2d.get_rigid_bodies():
		var rigid:RigidBody2D = child.rigidbody
		rigid.freeze = false

func _launch_rat() -> void:
	print("howdy")
	for child:SoftBody2D.SoftBodyChild in remy.soft_body_2d.get_rigid_bodies():
		var rigid:RigidBody2D = child.rigidbody
		var direction:Vector2 = (cheese.global_position - rigid.global_position).normalized()
		direction += Vector2(0,-0.5)
		rigid.linear_velocity = direction * 750
	

func _get_levels() -> void:
	var path:String = "res://Scenes/Levels/"
	var levels_arr:= DirAccess.get_files_at(path)
	
	for level_path in levels_arr:
		if level_path.contains(".remap"):level_path = level_path.trim_suffix(".remap")
		
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
