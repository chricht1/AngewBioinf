accsession=$1
genome_file=$2

if [ ! -f "$genome_file" ]; then
    python seq_from_gb.py $accsession $genome_file
fi

python detect_ol_cds.py $genome_file
