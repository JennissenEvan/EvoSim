extends Area2D

var dna
var current_gene

var world

const CHILD_DIST = 50

var energy = 0.0
var energy_loss = 0.02
var energy_to_reproduce = 10.0

var age = 0
var lifespan = 1000

var consuming_creatures = {}

func move(steps):
	var direction = Vector2(sin(rotation), -cos(rotation))
	position += steps * direction

func do_step():
	do_consumption()
	
	if dna != null:
		run_genes()
	
	if energy >= energy_to_reproduce + 5.0 and world != null:
		do_reproduction()
	
	energy -= energy_loss
	if energy <= 0.0:
		die()
	
	age += 1
	if age > lifespan:
		die()

func run_genes():
	if current_gene == null:
		if get_base_gene() == null:
			return
		else:
			current_gene = get_base_gene()
	
	var actions = 1
	var ran_genes = []
	while actions > 0:
		if not current_gene in dna.genes.keys():
			current_gene = get_base_gene()
		if current_gene in ran_genes:
			return
		if dna.genes[current_gene].is_action():
			actions -= 1
		else:
			ran_genes.push_back(current_gene)
		current_gene = dna.genes[current_gene].run_gene(self)

func do_consumption():
	for object in get_overlapping_areas():
		if object.is_in_group("food"):
			if dna.predation_level < 10:
				add_energy(1.0 - 0.1 * (dna.predation_level - 1))
				object.queue_free()
		if object.is_in_group("creature"):
			if dna.predation_level > 1 and object.dna.predation_level < self.dna.predation_level:
				if dna.predation_level >= 10:
					add_energy(object.energy)
					object.die()
				else:
					if not object in consuming_creatures.keys():
						consuming_creatures[object] = 0
	
	var remove_consumption_queue = []
	for creature in consuming_creatures:
		if not creature in get_overlapping_areas():
			remove_consumption_queue.push_back(creature)
		else:
			consuming_creatures[creature] += 1
			if consuming_creatures[creature] >= 2 * -(dna.predation_level - 10):
				add_energy(creature.energy)
				remove_consumption_queue.push_back(creature)
				creature.die()
	for creature in remove_consumption_queue:
		consuming_creatures.erase(creature)

func do_reproduction():
	var new_rotation = randf() * TAU
	var direction = Vector2(sin(new_rotation), -cos(new_rotation))
	var new_position = position + direction * CHILD_DIST
	var new_dna = dna.duplicate()
	new_dna.mutate(world.mutation_rate)
	world.spawn_creature(new_dna, new_position, new_rotation, energy_to_reproduce / 2.0)
	energy -= energy_to_reproduce

func die():
	self.queue_free()

func set_dna(new_dna):
	dna = new_dna
	current_gene = get_base_gene()
	var r = 1.0
	var b = 1.0
	if dna.predation_level > 5:
		b = 1.0 - 0.2 * (dna.predation_level - 5)
	if dna.predation_level < 5:
		r = 0.2 * (dna.predation_level)
	$Body.self_modulate = Color(r, 0, b)

func get_base_gene():
	if dna.default_gene == null:
		if dna.genes.size() <= 0:
			return null
		else:
			return dna.genes.keys().front()
	else:
		return dna.default_gene

func add_energy(energy_amount):
	energy += energy_amount