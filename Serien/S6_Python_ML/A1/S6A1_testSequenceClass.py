from Sequence import Sequence
print("--- Test of Sequence Class ---\n")

seq = Sequence("AAGCAATTCGGGAATTACGA")
print("instance of Sequence:")
print("Sequence Representation:")
print(seq.seqString)

subseq = seq[1:4]
print("\nsubsequence:")
print("Sequence Representation:")
print(subseq.seqString)

concat = subseq + Sequence("TATA")
print("\nconcatenated sequences:")
print("Sequence Representation:")
print(concat.seqString) 

revCompl = concat.getRevCompl()
print("\nreverse complement:")
print("Sequence Representation:")
print(revCompl.seqString)

rna = Sequence("GUACUAA")
print("\nreverse complement of RNA sequence")
print("Output:")
rna.getRevCompl()


newSeq = Sequence("AATATATACATAGACTATATA")
matchingSeqs = newSeq.findPattern(r"(TA){2}|(AT){2}")
print("\nmatches of " + newSeq.seqString + " for pattern TATA and ATAT:")
print("Sequence Representations:")
for seqMatch in matchingSeqs:
    print(seqMatch.seqString)