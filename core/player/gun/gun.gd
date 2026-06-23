class_name Gun
extends Node2D

@export var orbit_radius: float = 100
@export var radial_speed: float = 2
@export var projectile_count: int = 1
@export var burst: float = 0
@export var shooting_cooldown: float = 0.5
@export_range(0, 360, 0.1, "radians_as_degrees") var spread_angle: float = 0
@export var bullet: Bullet = preload("res://resources/bullets/default_bullet.tres").duplicate(true)
@onready var shootAudio: AudioStreamPlayer = $Shoot

@export var hit_effects: Array[HitEffect] = []
@export var bullet_effects: Array[BulletEffect] = []
@export var collision_effects: Array[CollisionEffect] = []

@onready var main_offset: Marker2D = $MainOffset
@onready var bullet_interval: Timer = $BulletInterval
@onready var shooting_cooldown_timer: Timer = $ShootingCooldownTimer


func _physics_process(delta: float) -> void:
	self.rotate(radial_speed * delta)


func shoot(normal: Vector2) -> void:
	if shooting_cooldown_timer.is_stopped():
		shootAudio.play()
		shooting_cooldown_timer.start(shooting_cooldown)
		for _i in projectile_count:
			if burst / projectile_count > 0.05:
				bullet_interval.start(burst / projectile_count)
				await bullet_interval.timeout
			var angle: float = randf_range(-spread_angle / 2, spread_angle / 2)
			create_bullet(normal.rotated(angle))

func create_bullet(normal: Vector2) -> void:
	var entity: BulletEntity = Bullet.create(get_tree().current_scene, bullet)
	entity.global_position = main_offset.global_position
	entity.bullet_controller.direction = normal


func update_bullet(new_bullet: Bullet) -> void:
	self.bullet = new_bullet
	self.bullet.bullet_effects.append(self.bullet_effects)
	self.bullet.collision_effects.append(self.collision_effects)
	self.bullet.hit_effects.append(self.hit_effects)
