cmd_list_help() {
  cat <<'EOF'
Usage:
  tallyman list [options]

Options:
  -d, --sort-date       sort by date (YYYY-MM-DD)
  -p, --sort-priority   sort by priority (HIGH, MEDIUM, LOW)
  -r, --reverse         reverse sort order (only with -d or -p)
  -h, --help            show this help

Notes:
  - With no sort option, tasks are shown in file order.
  - Sorting affects display only. IDs stay stable.
EOF
}

cmd_list() {
  if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
    cmd_list_help
    return 0
  fi

  ensure_table

  local sort_mode="" reverse=0

  while [ $# -gt 0 ]; do
    case "$1" in
      -d|--sort-date) sort_mode="date" ;;
      -p|--sort-priority) sort_mode="priority" ;;
      -r|--reverse) reverse=1 ;;
      -h|--help) cmd_list_help; return 0 ;;
      *)
        echo "tallyman: unknown option '$1' (see: tallyman list --help)" >&2
        return 1
        ;;
    esac
    shift
  done

  local rows
  rows="$(extract_rows)"

  # No sorting requested: keep file order.
  if [ -z "$sort_mode" ]; then
    if [ "$reverse" -eq 1 ]; then
      echo "tallyman: --reverse only applies with --sort-date or --sort-priority" >&2
      return 1
    fi
    render_markdown_table "tallyman to-do list" "$HEADER" "$RULE" "$rows"
    return 0
  fi

  local sort_flags=""
  if [ "$reverse" -eq 1 ]; then
    sort_flags="-r"
  fi

  case "$sort_mode" in
    date)
      # Field mapping:
      # 1=id 2=done 3=date 4=priority 5=desc
      rows="$(
        printf '%s\n' "$rows" \
          | awk -F'[[:space:]]*\\|[[:space:]]*' '{ print $3 "\t" $0 }' \
          | sort $sort_flags -k1,1 \
          | cut -f2-
      )"
      ;;
    priority)
      rows="$(
        printf '%s\n' "$rows" \
          | awk -F'[[:space:]]*\\|[[:space:]]*' '
              function pr(p){
                if (p=="HIGH") return 1;
                if (p=="MEDIUM") return 2;
                if (p=="LOW") return 3;
                return 9;
              }
              { printf "%d\t%s\n", pr($4), $0 }
            ' \
          | sort $sort_flags -k1,1n \
          | cut -f2-
      )"
      ;;
    *)
      echo "tallyman: internal error: unknown sort mode '$sort_mode'" >&2
      return 1
      ;;
  esac

  render_markdown_table "TO-DO" "$HEADER" "$RULE" "$rows"
}
