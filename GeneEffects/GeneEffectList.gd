const movement = [
preload("MoveForward.gd"),
preload("MoveBackward.gd"),
preload("TurnRight.gd"),
preload("TurnLeft.gd")
]

const sensory = [
preload("SenseFood.gd"),
preload("SensePrey.gd"),
preload("SensePredator.gd")
]

const logic = [
preload("FlipFlop.gd"),
preload("Random.gd")
]

const categories = [movement, sensory, logic]

static func get_random_effect():
	var category = categories[randi() % categories.size()]
	return category[randi() % category.size()].new()