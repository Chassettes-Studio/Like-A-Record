class_name Gun
extends Node2D

@export var orbit_radius: float = 100
@export var radial_speed: float = 2

@onready var main_offset: Marker2D = $MainOffset


func _ready() -> void:
	main_offset.position.x = orbit_radius


func _physics_process(delta: float) -> void:
	self.rotate(radial_speed * delta)


func shoot(normal: Vector2) -> void:
	var entity: BulletEntity = Bullet.create(preload("res://resources/bullets/default_bullet.tres"))
	entity.global_position = main_offset.global_position
	get_tree().current_scene.add_child(entity)
	entity.bullet_controller.direction = normal
