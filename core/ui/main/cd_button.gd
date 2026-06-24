class_name CdButton
extends Node2D

@export var character: Character
@export var n: int
@export var hub_music: AudioStreamPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var title: Label = $CanvasLayer/NinePatchRect/Title
@onready var desc: Label = $CanvasLayer/NinePatchRect/Desc
@onready var popup: NinePatchRect = $CanvasLayer/NinePatchRect

var mouse_in: bool = false
var is_selected: bool = false

@onready var sprite: Sprite2D = $Sprite

signal cd_selected

func _ready() -> void:
	sprite.modulate = Color(18.892, 18.892, 18.892, 	0.0)
	title.text = character.name
	desc.text = character.desc
	audio.stream = character.layers
	audio.play()
	audio.volume_db = -100

func _input(event: InputEvent) -> void:
	if mouse_in && event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed:
			select()

func select() -> void:
	sprite.modulate = Color(18.892, 18.892, 18.892, 0.4)
	Player.static_character = character
	cd_selected.emit(n)
	is_selected = true

func _on_area_2d_mouse_entered() -> void:
	mouse_in = true
	sprite.modulate = Color(18.892, 18.892, 18.892, 0.4)
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(audio, "volume_db", 0.0, 1.0)
	tween.tween_property(hub_music, "volume_db", -100.0, 1.0)
	tween.tween_property(popup, "offset_transform_position", Vector2(0.0, 0.0), 0.5)

func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
	if !is_selected:
		sprite.modulate = Color(18.892, 18.892, 18.892, 0.0)
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(audio, "volume_db", -100.0, 1.0)
	tween.tween_property(hub_music, "volume_db", 0.0, 1.0)
	tween.tween_property(popup, "offset_transform_position", Vector2(0.0, 550.0), 0.5)

func unselect(val: int) -> void:
	if n != val:
		is_selected = false
		sprite.modulate = Color(18.892, 18.892, 18.892, 0.0)
