# Useful one liners

## Handling fasta files

### Make a tsv table from fasta files

First column is sequence id, second is sequence 

```for i in $(ls -1 *.fasta); do awk '/^>/ { seq=""; id=substr($0, 2); sub(/[ \t]+$/, "", id); printf("%s\t", id); next } { seq = seq $0 } END { if (seq) print seq }' $i; done > sequence_table.tsv```
