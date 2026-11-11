import sys

def onehot(seq):
	offs = {"A":0,"C":1,"G":2,"T":3}
	res = [0]*len(seq)*4
	for i in range(len(seq)):
		res[i*4 + offs[seq[i]]] = 1
	return res



fh = open(sys.argv[1])
out = open(sys.argv[1]+"_onehot.tsv","w")

for line in fh:
	line = line.rstrip("\n\r")
	parts = line.split(" ")
	seq = parts[0]
	if len(parts) > 1:
		val = float(parts[1])
		print(val, *onehot(seq), sep="\t", file=out)
	else:
		print(*onehot(seq), sep="\t", file=out)

fh.close()
out.close()