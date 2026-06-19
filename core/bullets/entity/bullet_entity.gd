class_name BulletEntity
extends CharacterBody2D

@export var bullet_data: Bullet

@onready var bullet_controller: BulletController = $BulletController
@onready var area_collision: CollisionShape2D = $Area2D/AreaCollision
@onready var body_collision: CollisionShape2D = $BodyCollision
@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	sprite.texture = bullet_data.texture
	area_collision.shape = bullet_data.shape
	body_collision.shape = bullet_data.shape
	


func _on_bullet_controller_collided(collision: KinematicCollision2D) -> void:
	for effect: ImpactEffect in bullet_data.impact_effects:
		effect.apply(self, collision.get_collider() as Node2D)
