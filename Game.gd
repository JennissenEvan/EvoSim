extends Node

const Food = preload("res://Food.tscn")
const Creature = preload("res://Creature.tscn")

const SIZE = 4000

var mutation_rate = 0.01

var maxfood = 8000
var food_spawnrate = 8.0
var food_spawn = 0.0

var sim_speed = 10
var sim_speed_increment = 0
var sim_timer = 0.0

func _ready():
	randomize()
	change_sim_speed(0)
	for x in range(maxfood):
		spawn_food()
	var new_dna = load("res://DNA.gd").new()
	new_dna.add_gene(load("res://GeneEffects/Random.gd").new(), 1, 4)
	new_dna.add_gene(load("res://GeneEffects/Random.gd").new(), 2, 3)
	new_dna.add_gene(load("res://GeneEffects/TurnLeft.gd").new(), 0, 0)
	new_dna.add_gene(load("res://GeneEffects/TurnRight.gd").new(), 0, 0)
	new_dna.add_gene(load("res://GeneEffects/MoveForward.gd").new(), 0, 0)
	new_dna.default_gene = 0
	new_dna.predation_level = 1
	spawn_creature(new_dna, Vector2(SIZE / 2, SIZE), 0, 5.0)

func _process(delta):
	if Input.is_action_just_pressed("ui_increase"):
		change_sim_speed(1)
	if Input.is_action_just_pressed("ui_decrease"):
		change_sim_speed(-1)

func _physics_process(delta):
	sim_timer += delta
	if sim_timer >= 1.0 / (sim_speed * pow(2, sim_speed_increment)):
		do_creature_steps()
		cleanup_creatures()
		food_spawn += food_spawnrate
		while food_spawn >= 1.0:
			spawn_food()
			food_spawn -= 1.0
		sim_timer -= 1.0 / (sim_speed * pow(2, sim_speed_increment))

func change_sim_speed(change):
	sim_speed_increment += change
	if sim_speed_increment >= 4:
		sim_speed_increment = 4
	if sim_speed_increment <= -4:
		sim_speed_increment = -4
	$UI/SimSpeed.text = "Sim Speed: %sx" % pow(2, sim_speed_increment)

func spawn_food():
	if $Food.get_child_count() > maxfood:
		return
	
	var new_food = Food.instance()
	new_food.position = Vector2(randf(), randf()) * SIZE
	$Food.add_child(new_food)

func spawn_creature(dna = null, position = Vector2(0,0), rotation = 0, energy = 5.0):
	var new_creature = Creature.instance()
	new_creature.position = position
	new_creature.rotation = rotation
	new_creature.energy = energy
	if dna != null:
		new_creature.set_dna(dna)
	new_creature.world = self
	$Creatures.add_child(new_creature)

func do_creature_steps():
	for creature in $Creatures.get_children():
		creature.do_step()

func cleanup_creatures():
	for creature in $Creatures.get_children():
		var oob_x = creature.position.x < 0 or creature.position.x > SIZE
		var oob_y = creature.position.y < 0 or creature.position.y > SIZE
		if oob_x or oob_y:
			creature.die()
