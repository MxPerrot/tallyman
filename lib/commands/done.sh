cmd_done() {
  if [ $# -ne 1 ]; then
    echo "Usage: tallyman done ID" >&2
    exit 1
  fi

  ensure_table
  local id="$1" tmp
  ensure_cache_dir
  tmp="$(mktemp "$HOME/.cache/tallyman/tmp.XXXXXX.md")"

  awk -v id="$id" '
    BEGIN { found=0 }
    {
      if ($0 ~ "^" id "[[:space:]]*\\|" && $0 !~ "\\[x\\]") {
        found=1

        n = split($0, a, "|")

        for (i = 1; i <= n; i++) {
          cell = a[i]
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", cell)

          if (i == 2) {
            # Done column: keep literal [x]
            cell = "[x]"
          } else {
            # Other columns: strike through
            if (cell !~ /^~~.*~~$/) {
              cell = "~~" cell "~~"
            }
          }

          a[i] = " " cell " "
        }

        out = a[1]
        for (i = 2; i <= n; i++) out = out "|" a[i]
        print out
        next
      }
      print
    }
    END { exit !found }
  ' "$TALLYMAN_FILE" > "$tmp" || {
    echo "tallyman: no such ID '$id'" >&2
    rm -f "$tmp"
    exit 1
  }

  mv "$tmp" "$TALLYMAN_FILE"
  echo "Marked done: $id"
}
