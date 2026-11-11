import sys


def main():

    input_file = sys.argv[1]

    # a)
    with open(input_file, "r", encoding="utf-8") as f:
        lines = f.readlines()

    # b) 
    print(f"Anzahl der Zeilen: {len(lines)}")
    if not lines[-1].endswith("\n"):
        lines[-1] += '\n'
        lines[0] = lines[0].strip()

    # c)
    with open('output.txt', "w", encoding="utf-8") as f:
        f.writelines(reversed(lines))


if __name__ == "__main__":
    main()


# Beispielaufruf:
# python S5A3.py example.txt

# Ausgabe: 
# Anzahl der Zeilen: 4

# <erzeugt eine Datei names output.txt mit den Zeilen umgekehrter Reihenfolge>