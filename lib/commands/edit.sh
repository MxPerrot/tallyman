cmd_edit() {
  ensure_table
  host_exec "${EDITOR:-nano}" "$TALLYMAN_FILE"
}
