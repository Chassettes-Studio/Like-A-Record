class_name BulletEntity
extends CharacterBody2D

@export var bullet_data: Bullet

var bounces := 0
var pierces := 0

@onready var bullet_controller: BulletController = $BulletController
@onready var area_collision: CollisionShape2D = $Area2D/AreaCollision
@onready var body_collision: CollisionShape2D = $BodyCollision
@onready var sprite: Sprite2D = $Sprite
@onready var area_2d: Area2D = $Area2D

func _process(_delta: float) -> void:
	sprite.rotation = bullet_controller.direction.angle() - deg_to_rad(90.0)
	for effect in bullet_data.bullet_process_effect:
		effect.process(self, _delta)

func _ready() -> void:
	sprite.texture = bullet_data.texture
	sprite.scale = Vector2.ONE * 2 * (bullet_data.size / bullet_data.texture.get_width())
	sprite.modulate = bullet_data.color
	refresh_size()
	
func refresh_size() -> void:
	sprite.scale = Vector2.ONE * 2 * (bullet_data.size/bullet_data.texture.get_width())
	var shape := CircleShape2D.new()
	shape.radius = bullet_data.size
	area_collision.shape = shape
	body_collision.shape = shape


func _on_bullet_controller_collided(collision: KinematicCollision2D) -> void:
	for effect: CollisionEffect in bullet_data.collision_effects:
		effect.apply(self, collision.get_collider() as Node2D)
	if bounces <= 0:
		queue_free()
	else:
		bounces -= 1
		velocity = velocity.bounce(collision.get_normal())
		bullet_controller.direction = bullet_controller.direction.bounce(collision.get_normal())


func _on_area_2d_body_entered(body: Node2D) -> void:
	var enemy := body as EnemyEntity
	if enemy:
		for effect: HitEffect in bullet_data.hit_effects:
			effect.apply(self, enemy)
	if pierces <= 0:
		queue_free()
	else:
		pierces -= 1


func _on_area_2d_area_entered(area: Area2D) -> void:
	var hb := area as Hitbox
	if hb:
		hb.damage(bullet_data.damage)
		queue_free()
