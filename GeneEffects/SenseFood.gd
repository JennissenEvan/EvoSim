extends "BaseGeneEffect.gd"

func _effect(creature, con1, con2):
	for object in creature.get_node("Sight").get_overlapping_areas():
		if object.is_in_group("food"):
			return con2
	return con1
