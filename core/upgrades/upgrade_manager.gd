class_name UpgradeManager

static var upgrade_pool: Array[Upgrade]

static func _static_init() -> void:
	const path : String = "res://resources/upgrades/"
	for name: String in ResourceLoader.list_directory(path):
		var upgrade : Upgrade = load(path+name)
		if not upgrade.enabled: continue
		upgrade_pool.append(upgrade)

static func pick_upgrades(amount : int = 3) -> Array[Upgrade]:
	var temp_pool : Array[Upgrade] = upgrade_pool.duplicate()
	var ret: Array[Upgrade]
	for i : int in amount:
		var upgrade: Upgrade = pick_weighted(temp_pool)
		temp_pool.erase(upgrade)
		ret.append(upgrade)
	ret.shuffle()
	return ret
	
static func pick_weighted(upgrades: Array[Upgrade]) -> Upgrade:
	var total_weight : float = upgrades.reduce(func(accum: float, u : Upgrade) -> float: return accum + u.weight ,0)
	var rand := randf_range(0,total_weight)

	for upgrade in upgrades:
		if upgrade.weight > rand:
			return upgrade
		rand -= upgrade.weight
		
	return upgrades.pick_random() #for safety
	
	
static func upgrade_chosen(upgrade: Upgrade) -> void:
	if not upgrade.stackable:
		upgrade_pool.erase(upgrade)
	
