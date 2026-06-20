class_name EnemyEntity
extends CharacterBody2D

signal died

@export var enemy_data: Enemy

@export var target: Node2D

@onready var damage_shape: CollisionShape2D = $DamageArea/CollisionShape2D
@onready var body_shape: CollisionShape2D = $CollisionShape2D

@onready var movement_controller: SCPhysicsController = $SCPhysicsController
@onready var sprite: Sprite2D = $Sprite
@onready var name_label: Label = $NameLabel

var attack : EnemyAttack
var brain : EnemyBrain

var health : int

func _ready() -> void:
	sprite.texture = enemy_data.texture
	name_label.text = enemy_data.name
	sprite.scale = Vector2.ONE * 2 * (enemy_data.size/enemy_data.texture.get_width())
	var shape := CircleShape2D.new()
	shape.radius = enemy_data.size
	damage_shape.shape = shape
	body_shape.shape = shape
	health = enemy_data.max_health
	attack = enemy_data.attack.duplicate()
	brain = enemy_data.brain.duplicate()

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target) : return
	brain.process(self, delta)

func take_damage(value: int) -> void:
	modulate = Color(4,4,4)
	health -= value
	if health <= 0:
		died.emit()
		queue_free()
	await get_tree().create_timer(.1).timeout
	modulate = Color.WHITE
