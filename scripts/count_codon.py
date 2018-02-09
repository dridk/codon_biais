#!/usr/bin/python3
import sys 
from Bio import SeqIO

filename = sys.argv[1]


bases = ('A','C','G','T')
codons = [a+b+c for a in bases for b in bases for c in bases]

# print header 
header = ["genes"]
header += codons 


print("\t".join(header))


for record in SeqIO.parse(filename, "fasta"):

	# init io null 
	results = {}
	for i in codons:
		results[i] = 0

	# Count codon 

	for pos in range(0, len(record), 3):
		a = record[pos:pos+3]
		c = str(a.seq).upper()

		if len(c) == 3 :
			results[str(a.seq).upper()] += 1 



	line = [record.id]
	for c in codons:
		line += str(results[c])

	print("\t".join(line))
