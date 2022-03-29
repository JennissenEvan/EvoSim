extends "BaseGeneEffect.gd"

func _init():
	is_action = true

func _effect(creature, con1, con2):
	creature.rotation_degrees -= 5
	return con1
