class_name UpgradeMini
extends Control

@onready var icon_sprite: TextureRect = $MarginContainer/Case/Icon

func init(upgrade: Upgrade) -> void:
	icon_sprite.texture = upgrade.sprite
