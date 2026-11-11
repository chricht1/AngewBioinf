import sys
import numpy as np
import matplotlib.pyplot as plt

from Bio import SeqIO, SeqFeature


def main():
    with open(sys.argv[1]) as f:
        for rec in SeqIO.parse(f, "genbank"):
            print(f'Record-ID: {rec.id}')

            cdss = list(filter(lambda x: x.type == "CDS", rec.features))
            
            n_spliced_cds = 0
            exon_counts = []
            cds_lens = []
            intron_lens = []
            
            for cds in cdss: 
                n_exons = len(cds.location.parts)

                total_seq_len = cds.location.end - cds.location.start
                cds_len = len(cds)
                cds_lens.append(cds_len)

                if n_exons > 1: 
                    n_spliced_cds += 1
                    intron_lens.append(total_seq_len - cds_len)


                exon_counts.append(n_exons)

            
            print(f"There are {n_spliced_cds} spliced CDS out of {len(cdss)} CDS.")

            print("Exon count distribution per CDS:")
            print(np.unique(exon_counts, return_counts=True))

            plt.hist(exon_counts, bins=int(max(exon_counts)/2))
            plt.xlabel("Exon count")
            plt.title("CDS exon count distribution in A. Thaliana chr4")
            plt.savefig(f"{rec.id}_exon_count_distribution.png")

            total_exon_length = np.sum(cds_lens)
            total_intron_length = np.sum(intron_lens)
            total_gene_lengths = total_exon_length + total_intron_length
            print(f"Total gene nucleotides: {total_gene_lengths}")
            
            print(f"Total exon (CDS) nucleotides: {total_exon_length}, fraction of total gene nucleotides: {total_exon_length/total_gene_lengths} ")
            print(f"Total intron nucleotides: {total_intron_length}, fraction of total gene nucleotides: {total_intron_length/total_gene_lengths}")
        


if __name__ == "__main__":
    main()