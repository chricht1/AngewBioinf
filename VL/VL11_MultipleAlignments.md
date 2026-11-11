

#### Progressive Alignments: 
in Alignments dürfen um Gap-Symbole eingefügt werden, es dürfen aber nie wieder diese Gaps entfernt werden
- dadurch haben Progressive Alignment Verfahren akzeptable Laufzeit

CLUSTAL W ist nicht mehr aktuell

EBI stellt bekannteste aktuelle Tools in einer Webapplikation bereit
- Achtung: Parameter/Optionen der Tools sind nicht alle bei EBI einstellbar, als wenn Tool separat genutzt
CLUSTAL Omega: ist Quasi Nachfolger von CLUSTAL W

Emboss Gut:

Kalign: schnell

T-Coffee:
- GrundIdee: Paarw. Alignments verbessern
  - betrachte nicht nur Paarw Alignments, sondern Triplets (A,X,B)
    - für X setze alle anderen Seq. ein
  - Laufzeit: N^3 -> nicht bei sehr vielen Ausgangsseq. geeignet

- untersch. Variationen

MAFFT: vorallem für Alignment von Proteinseq. gemacht
- berücksicht physiko-chem. Eingensch. von Seq.
  - dazu numerische Repräsentation, deren Korellation berechnet wird
  - für Paarw. Alignments von einzelnen Seq.:
  - versch. Seq2 als Sliding-Window
  - identifiziere Blöcke von besonders ähnlichen Teilsequenzen
  - nutzt Fast-Fourier-Transformation (FFT)
    -> ziemlich schnell 

  - für Alignment von MSA's mit (MSA oder Seq) wende Guide-Tree-Verfahren an


WebPRANK: man kann auch phylogenie zw. Sequenzen mit eingeben (wird berücksichtigt)



### Alignment von Genomen:
- Genom besitzt Block-Inversionen, große versch von Seq.-Abschnitten, -Deletionen, Duplikationen 
- Globales Opt. Alignment nimmt Kollinearität an
- Blöcke die Korrespondieren, können normal Aligniert werden 

- paarw. Alignment von 2 Genomen 
- Zusammenfassung von kleineren zu größeren Blöcken


progressiveMauve: wird leider nicht mehr weiterentwickelt
- Guide Tree

- zeigt am Ende Überblick über Korresponendenzen aller Genome und lokale Ähnlichkeit



### Alignments in Biopython:
- kein Alignment Algorithmus Implementiert, nur IO/Format-Konversion von Alignments
- Berechnung von Statistiken/Scores von MSA's