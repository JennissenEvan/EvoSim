extends "BaseGeneEffect.gd"

var flip = false

func _effect(creature, con1, con2):
	flip = !flip
	if flip:
		return con1
	else:
		return con2
