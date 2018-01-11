

BEGIN {
	OFS="\t"
}

{
	name=$2
	name2=$13
	sens = $4 =="+" ? "forward" : "reverse"
	chrom=$3
	exon_count=$9
	tx_start=$5
	tx_end=$6

	split($10,exon_starts,",")
	split($11,exon_ends,",")


	for (i=1; i<length(exon_starts); i++)
	{
		start = exon_starts[i];
		end   = exon_ends[i];
		print(chrom, start, end, name2,sens, name)
	}

}