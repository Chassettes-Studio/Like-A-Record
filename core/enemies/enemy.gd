class_name Enemy
extends Resource

@export var name: String
@export var texture: Texture2D
@export var min_wave: int = 1
@export var weight: float = 1
@export var score: int = 100

@export var size: float = 100
@export var max_health : int = 1
@export var brain: EnemyBrain
@export var death_effects: Array[EnemyDeath]
@export var contact_effects: Array[EnemyContact]
