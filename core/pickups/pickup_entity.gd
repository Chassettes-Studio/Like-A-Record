class_name PickupEntity
extends Node2D

var speed: float = 100000

var velocity: Vector2

var target: Player

@onready var texture_rect: TextureRect = $TextureRect

@export var pickup: Pickup

func _ready() -> void:
	texture_rect.texture = pickup.texture


func _physics_process(delta: float) -> void:
	_update_velocity(delta)
	global_position += velocity * delta


func _update_velocity(delta: float) -> void:
	if not target:
		velocity = Vector2.ZERO
		return
	velocity = global_position.direction_to(target.global_position) * speed / global_position.distance_to(target.global_position)
		


func _on_follow_area_body_entered(body: Node2D) -> void:
	var player := body as Player
	if player:
		target = body


func _on_follow_area_body_exited(body: Node2D) -> void:
	if body == target:
		target = null

func _on_pickup_area_body_entered(body: Node2D) -> void:
	var player := body as Player
	if player:
		for effect in pickup.effects:
			effect.apply(player)
		queue_free()
