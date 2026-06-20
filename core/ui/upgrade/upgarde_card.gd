class_name UpgradeCard
extends Control

signal upgrade_chosen(upgrade: Upgrade)
signal free

var current_upgrade: Upgrade
var done: bool = false

@onready var cd_sprite: TextureRect = $MarginContainer/CD
@onready var case_sprite: TextureRect = $MarginContainer/Case
@onready var icon_sprite: TextureRect = $MarginContainer/Case/Icon
@onready var container: MarginContainer = $MarginContainer
@onready var popup: Control = $MarginContainer/Popup
@onready var popup_container: Control = $MarginContainer/Popup/MarginContainer
@onready var title: Label = $MarginContainer/Popup/MarginContainer/MarginContainer/VBoxContainer/Title
@onready var description: Label = $MarginContainer/Popup/MarginContainer/MarginContainer/VBoxContainer/Description


func init(upgrade: Upgrade) -> void:
	current_upgrade = upgrade
	icon_sprite.texture = current_upgrade.sprite
	title.text = current_upgrade.name
	description.text = current_upgrade.description


func upgrade_selected() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true)
	tween.tween_property(cd_sprite, "offset_transform_position_ratio", Vector2(0.0, -3.0), 0.4)
	await get_tree().create_timer(1).timeout
	free.emit()


func _on_margin_container_mouse_entered() -> void:
	if done: return
	z_index = 1
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true)
	tween.tween_property(container, "offset_transform_scale", Vector2(1.2, 1.2), 0.4)
	tween.tween_property(cd_sprite, "offset_transform_position_ratio", Vector2(0.0, -0.5), 0.4)
	tween.tween_property(cd_sprite, "offset_transform_rotation", 0.6, 0.4)
	tween.tween_property(popup, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.4)
	tween.tween_property(popup_container, "offset_transform_scale", Vector2(1.0, 1.0), 0.4)


func _on_margin_container_mouse_exited() -> void:
	if done: return
	z_index = 0
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
			done = true
			upgrade_selected()
			upgrade_chosen.emit(current_upgrade)
