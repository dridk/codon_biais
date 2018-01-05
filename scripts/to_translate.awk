

BEGIN {
	OFS="\t"
}

{
	name=$2
	name2=$13
	sens = $4 =="+" ? "forward" : "reverse"
	chrom=$3
	exon_count=$9
	cds_start=$7
	cds_end=$8

	split($10,exon_starts,",")
	split($11,exon_ends,",")

	#print("cds",cds_start, cds_end)


	for (i=1; i<length(exon_starts); i++)
	{
		if (exon_ends[i] >= cds_start && exon_starts[i] <= cds_end)
		{

		start = exon_starts[i] < cds_start ? cds_start : exon_starts[i]
		end   = exon_ends[i] > cds_end ? cds_end : exon_ends[i]
		print(chrom, start, end, name2,sens, name)

		}


	}

}