class_name ChangeSize
extends BulletEffect

@export var added_size : float = 30

func apply(entity: BulletEntity) -> void:
	entity.bullet_data.size += added_size
	entity.refresh_size()
	
