# Proteinstrukturen
## Funktionen von Proteinen:
- Katalyse
- Transport
- Regulation



- PDB größte Datenbank von Exp. best. Proteinstrukturen 
  - 3D-Ansicht im Browser
  - stärkerer Fokus auf Proteine im Menschen 
  - andere Stoffe, die in Protein Liganden 


- Alphafold Protein Structure Database
  - weitere DB von durch Alphafold vorhergesagte Proteinstrukturen
  - 3D-Ansicht mit Färbung der Confidenz-Scores


## Anfinsens Dogma: 
- hat gezeigt, dass Prot.-Str. sich allein aus AS-Seq. best. lässt (Nobelpreis)
- Experiment: Erhöhung d. Temp. -> vollst. Entfaltung Protein,
              wieder Senkung Temp. -> Rückfaltung 

- ist aber nicht so einfach Str. vorherzusagen:


## Levinthals Paradoxon: 
- Exp. viel mgl. Str. für Prot nach Länge
- 10^(47) für Länge 100 AS


## Experimentell: 
- sehr aufwändig
- pro Protein u. Person >= 1/2 Jahr Arbeit
- 90% Genauigkeit

## Computergestützt:
### Energieminimierung

### Templ. Based Modelling (TPM)
  - war lange Standardverfahren

### Neuronale Netze: Alphafold
- Alphafold: ca 60% mittlere Genauigkeit
  - weniger 
- Alphafold 2:
  - John Jumper (Biochemiker) hat biochem. 
  - Transformer-Basierte Architektur
    - ca. 90 mio. Parameter
  - nicht abh. von Templates
  - innerhalb kurzer Zeit 1000x mehr Proteinstr. als bisher bekannte bestimmt

  
  #### Funktionsweise:
  - Ausgangsinformationen/repräsentationen: 
    - MSA mit homolog. Informationen, Evolutionäre Information 
    - phys./ chem. Interaktionen zw. AS
    
  - Evoformer:
    - Verfeinerung der Ausgangsinformationen u. Anreicherung einer Repr. mit der anderen

  - Structure Module:


### Alphafold 3:
- Strukturvorhersage mit Kontext:
  - Liganden, Protein-Komplexe, inkl. DNA/RNA
- 5 Strukturen für eine Eingabe berechnet

#### Funktionsweise:
- Conformer-Generator:
  - best. der 3D-Molekülstruktur von Liganden (Nutzung bekanntes Modell)

- Pairformer (48 Blöcke) statt Evoformer (etwas kleiner)
  - MSA-Representation nicht mehr ganz neben Pair-Rep. durch Pairformer geschickt, sondern nur single Rep.


- Diffusion Module statt Str. Mod.
  - Technik wie in Bildgenerierung/Videogenerierung
  - aus Rauschen wird


### Alphafold-Scores:
- geringe lokale Konfidenz bei flexible Linkers u. loose Ends


## Protein-Design:
- Baker-Lab 2. Platz CASP-Wettbewerb 
- Nobelpreis 2024 Proteindesign


## FoldSeek:
- um schnell in großer Alphafold-DB zu suchen
  - geringer Verlust Sensitivität, dafür sehr starke Verkürzung der Suchzeit (wenige Sekunden vs. viele h)
- Idee von MMSeqs2 nutzen
- Strukturvorhersage Template-Basiert nicht Alphafold
- Strukturalphabet schaut mehr auf Lokale konformation
- VAE: 3Di-Codierung

- Ergebnis: 
  - Blau: Anfragestruktur
  - Gelb: Trefferprotein