cmd_add() {
  if [ $# -lt 2 ]; then
    echo "Usage: tallyman add HIGH|MEDIUM|LOW description..." >&2
    exit 1
  fi

  ensure_table

  local prio desc id date row
  prio="$(normalize_priority "$1")" || exit 1
  shift

  desc="$(sanitize_desc "$*")"
  id="$(next_id_for_desc "$desc")"
  date="$(date +"$DATE_FMT")"

  row="$id | [ ] | $date | $prio | $desc"
  echo "$row" >> "$TALLYMAN_FILE"
  echo "Added: $row"
}
