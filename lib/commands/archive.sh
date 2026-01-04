cmd_archive() {
  ensure_table
  ensure_parent "$TALLYMAN_ARCHIVE"

  grep '\[x\]' "$TALLYMAN_FILE" >> "$TALLYMAN_ARCHIVE"
  grep -v '\[x\]' "$TALLYMAN_FILE" > "$TALLYMAN_FILE.tmp"
  mv "$TALLYMAN_FILE.tmp" "$TALLYMAN_FILE"

  echo "Archived completed tasks."
}
