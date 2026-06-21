class_name EnemyEntity
extends CharacterBody2D

signal died

var dead := false

@export var enemy_data: Enemy

@export var target: Node2D

@onready var damage_shape: CollisionShape2D = $DamageArea/CollisionShape2D
@onready var body_shape: CollisionShape2D = $CollisionShape2D
@onready var freeze_timer: Timer = $FreezeTimer
@onready var damage_area: DamageArea = $DamageArea

@onready var movement_controller: SCPhysicsController = $SCPhysicsController
@onready var sprite: Sprite2D = $Sprite
@onready var name_label: Label = $NameLabel

const FREEZE_COLOR := Color.BLUE

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
	if not freeze_timer.is_stopped() : return
	brain.process(self, delta)

func take_damage(value: int) -> void:
	sprite.modulate = Color(4,4,4)
	health -= value
	if health <= 0:
		die()
	await get_tree().create_timer(.1).timeout
	sprite.modulate = Color.WHITE if freeze_timer.is_stopped() else FREEZE_COLOR
	
func die() -> void:
	if dead : return
	dead = true
	for effect in enemy_data.death_effects:
		effect.apply(self)
	Score.add_score(enemy_data.score)
	died.emit()
	queue_free()

func freeze(duration : float) -> void:
	if freeze_timer.is_stopped():
		damage_area.set_hittable(false)
		freeze_timer.start(duration)
		velocity *= 0
		movement_controller.direction *= 0
		sprite.modulate = FREEZE_COLOR
	else:
		var time_left := freeze_timer.time_left
		freeze_timer.stop()
		freeze_timer.start(time_left + duration)


func _on_freeze_timer_timeout() -> void:
	damage_area.set_hittable(true)
	sprite.modulate = Color.WHITE
