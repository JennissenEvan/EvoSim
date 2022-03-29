var default_gene

var genes = {}

var predation_level = 1

func mutate(rate):
	var deletion_list = []
	var new_genes = 0
	for gene in genes:
		if randf() < rate:
			genes[gene].con1 = get_random_gene()
		if randf() < rate:
			genes[gene].con2 = get_random_gene()
		if randf() < rate:
			genes[gene].gene_effect = load("res://GeneEffects/GeneEffectList.gd").get_random_effect()
		if randf() < rate:
			deletion_list.push_back(gene)
		if randf() < rate:
			new_genes += 1
	for gene in deletion_list:
		remove_gene(gene)
	for x in range(new_genes):
		add_gene()
	
	if randf() < rate:
		add_gene()
	
	if randf() < rate:
		if genes.size() > 0:
			default_gene = get_random_gene()
	
	if randf() < rate:
		predation_level += randi() % 3 - 1
		if predation_level > 10:
			predation_level = 10
		if predation_level < 1:
			predation_level = 1

func add_gene(effect = null, con1 = null, con2 = null):
	if effect == null:
		effect = load("res://GeneEffects/GeneEffectList.gd").get_random_effect()
	
	var new_id = 0
	while new_id in genes.keys():
		new_id += 1
	
	genes[new_id] = load("res://Gene.gd").new()
	genes[new_id].gene_effect = effect
	if con1 == null:
		con1 = get_random_gene()
	genes[new_id].con1 = con1
	if con2 == null:
		con2 = get_random_gene()
	genes[new_id].con2 = con2

func remove_gene(rm_gene):
	genes.erase(rm_gene)
	if default_gene == rm_gene:
		default_gene = get_random_gene()
	for gene in genes:
		if genes[gene].con1 == rm_gene:
			genes[gene].con1 = get_random_gene()
		if genes[gene].con2 == rm_gene:
			genes[gene].con2 = get_random_gene()

func get_random_gene():
	if genes.size() <= 0:
		return null
	return genes.keys()[randi() % genes.size()]

func duplicate():
	var new_dna = get_script().new()
	for gene in genes:
		new_dna.genes[gene] = genes[gene].duplicate()
	new_dna.predation_level = predation_level
	return new_dna
