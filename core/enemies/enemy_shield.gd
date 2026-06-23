extends Node2D

var angular_speed := 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += angular_speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	var bullet := body as BulletEntity
	if bullet and bullet.area_2d.get_collision_mask_value(2):
		bullet.queue_free()
