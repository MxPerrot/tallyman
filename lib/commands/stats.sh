cmd_stats() {
  ensure_table
  extract_rows | awk '
    /\[x\]/ {done++}
    /\[ \]/ {open++}
    END {
      print "Open:", open
      print "Done:", done
    }'
}
