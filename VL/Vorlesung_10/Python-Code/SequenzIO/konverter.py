import sys
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

# sequence.gb
recs = SeqIO.parse(sys.argv[1],"genbank")
SeqIO.write(recs,sys.argv[2],"fasta")
