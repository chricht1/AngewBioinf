import sys

# b.)
def load_codon_table(filename):
    codon_table = {}
    with open(filename, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            codon, aa = line.split("\t")
            codon_table[codon.strip()] = aa.strip()
    return codon_table


def translate_dna(seq, codon_table):
    # a.)
    seq = seq.upper().strip()
    remainder = len(seq) % 3

    if remainder != 0:
        print(
            f"Warnung: Sequenzlänge ist nicht durch 3 teilbar. "
            f"Die letzten {remainder} Nukleotide werden verworfen.",
            file=sys.stderr
        )
        seq = seq[:len(seq) - remainder]

    protein = []
    for i in range(0, len(seq), 3):
        codon = seq[i:i+3]
        # b.)
        protein.append(codon_table[codon])

    return "".join(protein)


def main():

    dna_seq = sys.argv[1]
    codon_file = sys.argv[2]

    codon_table = load_codon_table(codon_file)
    protein_seq = translate_dna(dna_seq, codon_table)
    print(protein_seq)


if __name__ == "__main__":
    main()


# Beispielaufruf:
# python S5A4.py ATGGCCATTG codons.tsv

# Ausgabe: 
# Warnung: Sequenzlänge ist nicht durch 3 teilbar. Die letzten 1 Nukleotide werden verworfen.
# MAI
