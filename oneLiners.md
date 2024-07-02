# Useful one liners

## Handling fasta files

### Make a tsv table from fasta files

First column is sequence id, second is sequence. Can be useful for preparing ENA annotated sequence uploads with many sequences.

```for i in $(ls -1 *.fasta); do awk '/^>/ { seq=""; id=substr($0, 2); sub(/[ \t]+$/, "", id); printf("%s\t", id); next } { seq = seq $0 } END { if (seq) print seq }' $i; done > sequence_table.tsv```

# Turn a single space separated GTF (yes, I have seen that on data published with papers)
Will print tabs as spacers between fields 1-8. Spaces in the ninth field are kept. Do note that it inserts an space at the end.

```awk 'BEGIN{OFS="\t"} {for (i=1; i<=8; i++) {printf "%s%s", $i, (i==8 ? OFS : OFS)} for (i=9; i<=NF; i++) {printf "%s ", $i} printf "\n"}' input.gtf```

If problematic, just remove that last whitespace with:
sed 's/ $//g' fix_dmel_scaffold2_merge_V5.gtf > fixed_input.gtf
