class_name Hitbox
extends TogglableArea2D

signal hurt(value: float)

func damage(value: float) -> void:
	hurt.emit(value)
