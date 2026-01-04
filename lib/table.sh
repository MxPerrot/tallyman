ensure_parent() {
  mkdir -p "$(dirname "$1")"
}

ensure_table() {
  ensure_parent "$TALLYMAN_FILE"

  if [ ! -s "$TALLYMAN_FILE" ]; then
    {
      echo "# TO-DO"
      echo
      echo "$HEADER"
      echo "$RULE"
    } > "$TALLYMAN_FILE"
  fi
}

extract_rows() {
  grep -E '^[^|]+[[:space:]]*\|[[:space:]]*\[[ xX]\][[:space:]]*\|' "$TALLYMAN_FILE" || true
}
