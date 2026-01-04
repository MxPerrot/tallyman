host_exec() {
  if command -v "$1" >/dev/null 2>&1; then
    "$@"
  elif command -v flatpak-spawn >/dev/null 2>&1; then
    flatpak-spawn --host "$@"
  else
    echo "tallyman: cannot execute '$1'" >&2
    exit 127
  fi
}

normalize_priority() {
  local p
  p="$(printf '%s' "${1:-MEDIUM}" | tr '[:lower:]' '[:upper:]')"
  case "$p" in
    HIGH|MEDIUM|LOW) printf '%s' "$p" ;;
    *)
      echo "tallyman: invalid priority '$1'" >&2
      return 1
      ;;
  esac
}

sanitize_desc() {
  local s="$1"
  s="${s//|/\/}"
  printf '%s' "$s"
}

slug_from_desc() {
  printf '%s\n' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | tr -cs 'a-z0-9' ' ' \
    | awk '{ for (i=1;i<=NF;i++) out=out substr($i,1,1); print substr(out,1,6) }'
}

next_id_for_desc() {
  local base n=1
  base="$(slug_from_desc "$1")"
  [ -z "$base" ] && base="task"
  while grep -q "^$base-$n[[:space:]]*|" "$TALLYMAN_FILE"; do
    n=$((n+1))
  done
  printf '%s-%d' "$base" "$n"
}

ensure_cache_dir() {
  mkdir -p "$HOME/.cache/tallyman"
}
