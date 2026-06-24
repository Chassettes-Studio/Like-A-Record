extends Node2D

@onready var line_2d: Line2D = $Line2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ray_cast_2d.is_colliding():
		line_2d.set_point_position(1,Vector2(global_position.distance_to(ray_cast_2d.get_collision_point()) + 50,0))
	else:
		line_2d.set_point_position(1,Vector2(2000,0))
		
	
