class_name DeathScreen
extends CanvasLayer

@onready var score: Label = $Score
@onready var home: ColorRect = $Home
@onready var restart: ColorRect = $Restart
@onready var lost: AudioStreamPlayer = $Lost
@onready var click: AudioStreamPlayer = $Click


func _ready() -> void:
	Score.reset()
	lost.play()
	home.modulate = Color(1.0, 1.0, 1.0, 0.0)
	restart.modulate = Color(1.0, 1.0, 1.0, 0.0)
	get_tree().paused = true
	score.text = "You survived until wave : " + str(Score.get_wave()) + "\nWith a score of : " + str(Score.get_score())
	await get_tree().create_timer(1).timeout
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(score, "visible_ratio", 1.0, 2.0)


func _on_home_mouse_entered() -> void:
	home.modulate = Color(1.0, 1.0, 1.0, 0.65)

func _on_home_mouse_exited() -> void:
	home.modulate = Color(1.0, 1.0, 1.0, 0.0)

func _on_restart_mouse_entered() -> void:
	restart.modulate = Color(1.0, 1.0, 1.0, 0.65)

func _on_restart_mouse_exited() -> void:
	restart.modulate = Color(1.0, 1.0, 1.0, 0.0)


func _on_home_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed:
			click.play()
			await get_tree().create_timer(0.2).timeout
			get_tree().paused = false
			get_tree().change_scene_to_file("res://core/ui/main/canvas.tscn")

func _on_restart_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed:
			click.play()
			await get_tree().create_timer(0.5).timeout
			get_tree().paused = false
			get_tree().change_scene_to_file("res://core/levels/test_level.tscn")
