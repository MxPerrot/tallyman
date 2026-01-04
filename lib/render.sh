render_markdown_table() {
  local title="$1" header="$2" rule="$3" rows="$4"
  local tmp

  ensure_cache_dir
  tmp="$(mktemp "$HOME/.cache/tallyman/tmp.XXXXXX.md")"

  {
    echo "# $title"
    echo
    echo "$header"
    echo "$rule"
    printf '%s\n' "$rows"
  } > "$tmp"

  host_exec glow -s tallyman -w 0 "$tmp" || host_exec glow "$tmp"
  rm -f "$tmp"
}
