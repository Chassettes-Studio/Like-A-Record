extends Node2D

var mouse_in: bool = false

@onready var stairs: Polygon2D = $Polygon2D
@onready var enter: AudioStreamPlayer = $Enter
@onready var music: AudioStreamPlayer = $Music
@onready var color_rect: ColorRect = $ColorRect
@onready var step: AudioStreamPlayer = $Step
@onready var score: Label = $Score


func _ready() -> void:
	score.text = str(Score.hs)
	stairs.color = Color(1.0, 1.0, 1.0, 0.0)
	enter.play()
	await get_tree().create_timer(0.5).timeout
	music.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://core/levels/test_level.tscn")

func _input(event: InputEvent) -> void:
	if mouse_in && event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed:
			goToScene()

func _on_area_2d_mouse_entered() -> void:
	mouse_in = true
	stairs.color = Color(1.0, 1.0, 1.0, 0.65)


func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
	stairs.color = Color(1.0, 1.0, 1.0, 0.0)

func goToScene() -> void:
	step.play()
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(color_rect, "color", Color(), 0.5)
	
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://core/levels/test_level.tscn")
