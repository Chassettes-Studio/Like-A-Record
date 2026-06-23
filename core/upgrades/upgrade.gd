class_name Upgrade
extends Resource

@export var name: String
@export_multiline() var description: String
@export var sprite: Texture2D

@export var stackable: bool = true
@export var enabled: bool = true
@export var bullet_effects: Array[BulletEffect]
@export var gun_effects: Array[GunEffect]
@export var collision_effects: Array[CollisionEffect]
@export var hit_effects : Array[HitEffect]
@export var player_effects: Array[PlayerEffect]
@export var player_shoot_effects: Array[PlayerShootEffect]
