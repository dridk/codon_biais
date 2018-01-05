
function generate_codon()
{
	nuc[1] = "A";
	nuc[2] = "C";
	nuc[3] = "G";
	nuc[4] = "T";
	delete codons 
	for (i in nuc)
	{
		for (j in nuc)
		{
			for (k in nuc)
			{
				codons[nuc[i]nuc[j]nuc[k]] = 0
			}
		}
	}
}

BEGIN {
generate_codon()
printf("gene\t")
for (i in codons)
	printf("%s\t",i)

printf("\n")

}

$1 ~ ">" {
current_name = $2 
generate_codon()
} 


$1 !~ ">" {

for (i=1; i<=length($0); i+=3)
{
	codon = toupper(substr($0,i, 3))
	codons[codon]+=1
}

printf("%s\t", current_name)
for (i in codons)
	printf("%s\t",codons[i])

printf("\n")





} 



