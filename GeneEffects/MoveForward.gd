extends "BaseGeneEffect.gd"

func _init():
	is_action = true

func _effect(creature, con1, con2):
	creature.move(5)
	return con1
