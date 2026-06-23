class_name Enemy
extends Resource

@export var name: String
@export var texture: Texture2D
@export var min_wave: int = 1
@export var max_wave: int = 9999
@export var weight: float = 1
@export var score: int = 100
@export var mass: float = 1
@export var size: float = 100
@export var max_health : int = 1
@export var brain: EnemyBrain
@export var spawn_effects: Array[EnemySpawnEffect]
@export var death_effects: Array[EnemyDeath]
@export var contact_effects: Array[EnemyContact]
