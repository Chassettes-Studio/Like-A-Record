class_name UpgradeManager

static var upgrade_pool: Array[Upgrade]

static func _static_init() -> void:
	const path : String = "res://resources/upgrades/"
	for upgrade: String in ResourceLoader.list_directory(path):
		upgrade_pool.append(load(path+upgrade))

static func pick_upgrades(amount : int = 3) -> Array[Upgrade]:
	var temp_pool : Array[Upgrade] = upgrade_pool.duplicate()
	var ret: Array[Upgrade]
	for i : int in amount:
		var upgrade: Upgrade = temp_pool.pick_random()
		temp_pool.erase(upgrade)
		ret.append(upgrade)
	return ret
	
