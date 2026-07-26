extends Control

@onready var ap: AnimationPlayer = %AnimationPlayer

signal tween_finished

func play() -> void:
	visible = true
	var tween:Tween = create_tween()
	tween.tween_property(self,"modulate:a",1,0.5)
	await tween.finished
	tween_finished.emit()
	
	ap.play("spin")

func stop() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(self,"modulate:a",0,0.5)
	await tween.finished
	tween_finished.emit()
	visible = false
	
	ap.stop()
