class_name LaserEntity
extends Node2D

@export var duration: float = 1.5
@export var beam_width: float = 10
@export var hit_count: int = 3

@onready var shape_cast_2d: ShapeCast2D = $ShapeCast2D


func _physics_process(delta: float) -> void:
	pass
