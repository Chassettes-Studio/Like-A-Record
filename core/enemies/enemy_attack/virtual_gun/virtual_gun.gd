class_name VirtualGun
extends Resource

@export var projectile_count: int = 1
@export var burst: float = 0
@export var shooting_cooldown: float = 0.5
@export_range(0, 360, 0.1, "radians_as_degrees") var spread_angle: float = 0

var is_on_cooldown: bool = false


func shoot(normal: Vector2, entity: EnemyEntity, bullet: Bullet) -> void:
	if not is_on_cooldown:
		entity.get_tree().create_timer(shooting_cooldown).timeout.connect(_on_shooting_cooldown_timer_timeout)
		is_on_cooldown = true
		for _i in projectile_count:
			if burst / projectile_count > 0.05:
				await entity.get_tree().create_timer(burst / projectile_count).timeout
			var angle: float = randf_range(-spread_angle / 2, spread_angle / 2)
			create_bullet(normal.rotated(angle), entity, bullet)


func create_bullet(normal: Vector2, entity: EnemyEntity, bullet: Bullet) -> void:
	var bullet_entity: BulletEntity = Bullet.create(entity.get_tree().current_scene, bullet, true)
	bullet_entity.global_position = entity.global_position
	bullet_entity.bullet_controller.direction = normal


func _on_shooting_cooldown_timer_timeout() -> void:
	is_on_cooldown = false
