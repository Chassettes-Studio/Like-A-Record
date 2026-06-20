class_name TogglableArea2D
extends Area2D

func set_hittable(hittable: float) -> void:
	for child: Node in get_children():
		var colshape := child as CollisionShape2D
		if colshape:
			colshape.disabled = not hittable
