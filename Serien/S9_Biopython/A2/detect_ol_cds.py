import sys
import numpy as np
import matplotlib.pyplot as plt

from Bio import SeqIO, SeqFeature


# usage: python detect_overlap_codingseqs.py <genbank_file>

def get_overlapping_feat(cds1, cds2):
    if cds1.location.strand == cds2.location.strand and cds2.location.start < cds1.location.end:
        return cds2
        
def main():
    with open(sys.argv[1]) as f:
        for rec in SeqIO.parse(f, "genbank"):
            print(rec.id)

            # for feat in rec.features:
            #     print("{0} {1} {2}".format(feat.type,feat.location,feat.location.strand))

            # CDS means coding sequence
            cdss = list(filter(lambda x: x.type == "CDS", rec.features))
            print("Locations of overlapping coding sequences:")
            n_overlaps = 0
            ol_sizes = []
            for i, cds in enumerate(cdss):
                s1 = int(cds.location.start)
                e1 = int(cds.location.end)
            
                nextCDSs = cdss[i+1:]
                for feat in nextCDSs:
                    s2 = int(feat.location.start)
                    e2 = int(feat.location.end)
                    
                    if s2 > e1:
                        break
                    
                    if feat.location.strand == cds.location.strand:
                        size = (e1 - s2)+1
                        ol_sizes.append(size)
                        print(f"{[s1, e1]}, {[s2, e2]}, size: {size}")
                        n_overlaps += 1

            print(f"Found {n_overlaps} overlaps in {len(cdss)} CDS.")
            
            plt.hist(ol_sizes, bins=int(max(ol_sizes)/2))
            plt.xlabel("Overlap size")
            plt.title("CDS overlap size distribution in E. coli")
            plt.savefig(f"{rec.id}_overlap_size_distribution.png")

            print("Sizes and their frequencies:")
            print(np.unique(ol_sizes, return_counts=True))
            

if __name__ == "__main__":
    main()