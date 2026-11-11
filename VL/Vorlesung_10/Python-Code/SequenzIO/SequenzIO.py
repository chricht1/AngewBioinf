import sys
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

# beispiel.fa
for seq_record in SeqIO.parse(sys.argv[1],"fasta"):
	print(seq_record.id)
	print(seq_record.seq)

