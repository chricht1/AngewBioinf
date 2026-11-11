import sys

base = sys.argv[1]

complement = {"A": "U", "U": "A", "C": "G", "G": "C"}

try: 
    print(complement[base])
except KeyError:
    print("Ungültige Base")

# Beispielaufruf:
# python S5A2.py A

# Ausgabe: U