## Analyse von Expressionsdaten:

### Qualitätskontrolle (QC):

#### Fastq-Format:
- Qualitätsscore (Phread) ist Einschätzung Fehlerwhk., kommt von Sequenzierverfahren
		
#### FastQC:
- trimming:
- adaptoren
- auseinandersortieren wenn Multiplexing

- starke abweichung basengehalt abh. von Seq.-Pos. deutet auf mgl. mitsequenzierte Adapter hin -> Adapter-Content-Kriterium
- nächstes Qual.-Krit. nicht so viel Gewicht beimessen


## Short-Read-Alignment:
### Mapper:
- erstelle zuerst Index-Struktur:
  - suche der Seq. in Genom linear in Größe des Genoms
Suffix-Arrays
  - FM-Idx

- dann mapping

#### Bowtie kann nur sehr kurze in dels nutzen, kann nicht Splicing berücksichtigen


`bowtie2-build TAIR10.fa TAIR10`
`bowtie2 -x TAIR10 -U SRR3498212.fastq.gz -S bowtie.sam`

- fasta ist Genomdatei
- -U flag + fastq datei sind reads die gemappt wd. sollen
- bei paired-end 2 fastq-Dateien 

  Sam-Format:
  - CIGAR-Str. wie edit skript für Alignment 



#### STAR: 
- nutzt auch FM-Idx, von gleichen Leuten wie Bowtie entw.
- kann auch Pangenome
- verlässlich, schnell (Jans-Lieblingsmapper)
- nutzt auch Suffix-Arrays?
- index dir man kann gg. mehrere genome gleichz. mappen

  - “--readFilesCommand” Mgl. zum Entpacken input file spezifizieren: z. B. gunzip -c


- wo liegen gemappte reads auf genom?
  - steht in gff- Datei

#### Quantifik.:
	featureCounts: -t Flag um anzugeben welche Regionen Quantifiziert wd. sollen

  - gibt am Ende Zähltabelle aus für jedes Transkript
  - mehrere Spalten z. B. Zählwert, norm. TPM-Counts, effekt. Länge, …


### Pseudo-Alignment:
- viel Zwischenspeicher-Aufwand bei Mapping-basierter Quantifik. um am Ende nur Zähltab. zu erhalten
- eff. Weg ist Pseudo-Alignment
- Kallisto

- Salmon: wird von Leo Pachter (kallisto) gebasht (haben alles kopiert…)


- bioconductor wie bioconda für R ?!
  - man braucht spez. Paketmanager BiocManager
  - DESeq2 edgeR vglbar
  - DESeq veraltet

  - Daten als NB-Vert. mod., da hohe Var. aufweisen, lässt sich gut auf Daten anpassen


### DESeq2:
- Design-Matrix spezifizieren
  - R-Formel Format:
    - ~ Variable + Variable
    - + sind unabhängige Effekte
    - * abhängige Effekte

#### Bsp.-Daten:
- versch. Zelllinien analysiert
- DESeq-Dataset: Spalten sind untersch. Experimente
  - colSums:
    - Gesamtzahl Reads variiert um Fakt. 2 zw. Exp.
    - Absolutzählwerte weichen stark voneinander ab

  - Verteilung Zählwerte visualisieren: 
    - logarithmieren: log(count)+1
  - Modell DESeq: Size-Factor für Tiefer seq. library teilen wir durch 2
  - Mittelwerte ohne Dispersion könnte man mit Poisson-Vert. normalisieren
  
  - Empirical Bayes Varianzanpassung:

    - Schätzung Varianz für ähnl. expr. Gene nach dess mean of norm. counts (einmal für alle gene)
    - wenn Abweichung zu groß keine anpassung

    - DESeq2 normalisierung


