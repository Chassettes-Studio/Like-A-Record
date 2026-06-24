class_name SpawnBulletAroundShape
extends BulletProcessEffect

@export var bullet: Bullet
@export var projectile_count: int = 4
@export var cooldown: float = 2
@export var max_burst_count: int = 2
@export var burst_cooldown: float = 1

var elapsed_time: float = 0
var burst_count: int = 0

func process(entity: BulletEntity, delta: float) -> void:
	elapsed_time += delta
	if elapsed_time > cooldown and burst_count != max_burst_count:
		if elapsed_time > burst_cooldown + cooldown:
			elapsed_time -= burst_cooldown
			burst_count += 1
			create_bullets(entity)
	if burst_count == max_burst_count:
		elapsed_time -= cooldown
		burst_count = 0

func create_bullets(entity: BulletEntity) -> void:
	var direction: Vector2 = Vector2.RIGHT
	for i in projectile_count:
		var bullet_entity: BulletEntity = bullet.create(entity, bullet, true)
		bullet_entity.bullet_controller.direction = direction
		direction = direction.rotated(TAU/projectile_count)
