
rule final:
	input:
		"final.tsv", "gene_orientation.tsv"


rule count_codon:
	input:
		"final.fa"
	output:
		"final.tsv"
	shell:
		"cat {input} | awk -f scripts/count_codon.awk > {output}"

rule genelist_orientation:
	input:
		forward="translate.forward.tab",
		reverse="translate.reverse.tab"
	output:
		final     = "gene_orientation.tsv",
		unsorted  = temp("unsorted.tsv")
	shell:
		"cat {input.forward}|cut -f1|sort |uniq|awk \'BEGIN{{OFS=\"\t\"}}{{print $0,\"+\"}}\' >  {output.unsorted};"
		"cat {input.reverse}|cut -f1|sort |uniq|awk \'BEGIN{{OFS=\"\t\"}}{{print $0,\"-\"}}\' >> {output.unsorted};"
		"sort -k1 {output.unsorted} > {output.final}"



rule combine:
	input:
		f = "translate.forward.fa",
		r = "translate.reverse.rev.fa"
	output:
		"final.fa"
	shell:
		"cat {input} > {output}"

rule translate:
	input:
		"data/refGene.txt.gz"
	output:
		"translate.bed"
	shell:
		"zcat {input}|awk -f scripts/to_translate.awk > {output}"

rule create_reverse:
	input:
		"translate.bed"
	output:
		"translate.reverse.bed"
	shell:
		"cat {input}|grep reverse > {output}"

rule create_forward:
	input:
		"translate.bed"
	output:
		"translate.forward.bed"
	shell:
		"cat {input}|grep forward > {output}"


rule getfasta:
	input:
		"translate.{sens}.bed"
	output:
		"translate.{sens}.tab"
	params:
		hg19="data/hg19.fa"
	shell:
		"bedtools getfasta -fi {params.hg19} -bed {input} -fo {output} -name -tab 2> /dev/null"


rule concate_seq:
	input:
		"{name}.tab"
	output:
		"{name}.fa"
	shell:
		"cat {input}|awk -f scripts/concate_exon.awk > {output}"


rule reverse : 
	input:
		"{name}.fa"
	output:
		"{name}.rev.fa"
	shell:
		"seqtk seq -r {input} > {output}"