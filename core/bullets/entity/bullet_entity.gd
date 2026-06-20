class_name BulletEntity
extends CharacterBody2D

@export var bullet_data: Bullet

var bounces := 0

@onready var bullet_controller: BulletController = $BulletController
@onready var area_collision: CollisionShape2D = $Area2D/AreaCollision
@onready var body_collision: CollisionShape2D = $BodyCollision
@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	sprite.texture = bullet_data.texture
	area_collision.shape = bullet_data.shape
	body_collision.shape = bullet_data.shape


func _on_bullet_controller_collided(collision: KinematicCollision2D) -> void:
	for effect: CollisionEffect in bullet_data.collision_effects:
		effect.apply(self, collision.get_collider() as Node2D)
	if bounces <= 0:
		queue_free()
	else:
		velocity = velocity.bounce(collision.get_normal())


func _on_area_2d_body_entered(body: Node2D) -> void:
	var enemy := body as EnemyEntity
	if enemy:
		for effect: HitEffect in bullet_data.hit_effects:
			effect.apply(self,enemy)
			
