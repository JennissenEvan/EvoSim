extends "res://GeneEffects/BaseGeneEffect.gd"

func _effect(creature, con1, con2):
	if randi() % 2 == 0:
		return con1
	else:
		return con2