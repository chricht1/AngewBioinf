# Alignment-Suche in großen Sequenzdatenbanken
- finde ähnliche Sequenzen zu Anfrageseq. (Query) in großer Sequenz-Datenbank


## BLAST (findet norm. fast alle ähnl. Seq. nach best. Score sehr effizient): 
- Gesamt-Alignment-Score aus Ähnlichkeitsscores zwischen Elementen der Sequenzen
- bilde Wortliste (Seed-Liste) von kurzen Teilwörtern aus Query u. DB und weiteren nach Alignment-Score ähnlichen Wörtern zu diesen
- suche nach exakten Matches (exakte Alignments) Wortliste mit DB
  - Scanning: gute (nach Score) volle Alignments sollten kurze Abschnitte enthalten, die exakt matchen
    - (Heuristik) da Suche beschränkt
  - Suche von kurzen exakten Matches in großer Seq.-DB mit Index sehr effizient durchführbar (FM-Index?) 
- Extend: erweitere diese vielversprechenden Positionen um größere Alignments zu erhalten beidseitig bis Score-Schwelle unter letztbestem Score unterschritten
  - optional kann dies unter Berücksichtigung von Gaps erfolgen (per DP) (Gapped-Alignment) 
- erhaltene Alignments nur mit Score >= S erhalten auch High Scoring Segment Pairs (HSPs) genannt  

### E-Value (Expectation-Value):
- für HSP def.: Wie viele Alignments **mit gewähltem Score S** erwarten wir durch Zufall, also bei zufälliger (beliebiger) Query in zufälliger DB (gleiche Längen)
- wenn E-Value > 1 ist Ergebnis oft wertlos


PSI-BLAST:
- suche nach Alignments und erweitere um  multiples Alignment schrittweise um best. gefundene Matches
- finde weiter entfernt liegende Sequenz-Matches

Profile HMMs:
- positionsspezifische Wahrscheinlichkeit/Güte des Alignments definieren

JackHMMer:
- schrittweise neue Sequenzen finden und MSA daraus bilden und 


Conserved Domain Database (CDD):
- Zusammensetzung aus mehreren DBs
- größer als andere DBs aber dafür mgl. nicht so gut kontrolliert