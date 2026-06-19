extends Control

@onready var cd_sprite: TextureRect = $MarginContainer/CD
@onready var case_sprite: TextureRect = $MarginContainer/Case
@onready var icon_sprite: TextureRect = $MarginContainer/Case/Icons
@onready var container: MarginContainer = $MarginContainer
@onready var popup: Control = $MarginContainer/Popup
@onready var popup_container: Control = $MarginContainer/Popup/MarginContainer
@onready var title: Label = $MarginContainer/Popup/MarginContainer/MarginContainer/VBoxContainer/Title
@onready var description: Label = $MarginContainer/Popup/MarginContainer/MarginContainer/VBoxContainer/Description

var upgrade: Upgrade

func _ready() -> void:
	icon_sprite.texture = upgrade.sprite
	title.text = upgrade.name
	description.text = upgrade.description

func _on_margin_container_mouse_entered() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true)
	tween.tween_property(container, "offset_transform_scale", Vector2(1.2, 1.2), 0.4)
	tween.tween_property(cd_sprite, "offset_transform_position_ratio", Vector2(0.0, -0.5), 0.4)
	tween.tween_property(cd_sprite, "offset_transform_rotation", 0.6, 0.4)
	tween.tween_property(popup, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.4)
	tween.tween_property(popup_container, "offset_transform_scale", Vector2(1.0, 1.0), 0.4)

func _on_margin_container_mouse_exited() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true)
	tween.tween_property(container, "offset_transform_scale", Vector2(1.0, 1.0), 0.4)
	tween.tween_property(cd_sprite, "offset_transform_position_ratio", Vector2(0.0, 0.0), 0.4)
	tween.tween_property(cd_sprite, "offset_transform_rotation", 0.0, 0.4)
	tween.tween_property(popup, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.4)
	tween.tween_property(popup_container, "offset_transform_scale", Vector2(0.0, 0.0), 0.4)

func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed:
			print("OUI")
