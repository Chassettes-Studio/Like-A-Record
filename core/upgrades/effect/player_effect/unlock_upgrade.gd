class_name UnlockUpgrade
extends PlayerEffect

@export var target_upgrades : Array[Upgrade]

func apply(_player: Player) -> void:
	for upgrade in target_upgrades:
		upgrade.locks -= 1
		if upgrade.locks == 0:
			UpgradeManager.upgrade_pool.append(upgrade)
