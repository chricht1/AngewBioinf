import sys
from Bio import Entrez, SeqIO

# usage: python seq_from_gb.py <genbank_id> <output_fasta>

genbank_id = sys.argv[1]
Entrez.email = "christian.richter@student.uni-halle.de"
handle = Entrez.efetch(db="nucleotide", retmode="text",rettype="gbwithparts", id=genbank_id)

# print(handle) # output: <_io.TextIOWrapper encoding='UTF-8'>

recs = SeqIO.parse(handle, "genbank")


# to analyze annotations use genbank format
# to get sequence use fasta format

SeqIO.write(recs, sys.argv[2], "genbank")

