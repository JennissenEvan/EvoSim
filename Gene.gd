var con1
var con2

var gene_effect

func run_gene(creature):
	return gene_effect._effect(creature, con1, con2)

func is_action():
	return gene_effect.is_action

func duplicate():
	var new_gene = get_script().new()
	new_gene.con1 = con1
	new_gene.con2 = con2
	new_gene.gene_effect = gene_effect.get_script().new()
	return new_gene
