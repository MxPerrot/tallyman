usage() {
  cat <<'EOF'

  tallyman — A to-do script for the Fedora CLI.
                                    by MxPerrot

Usage:
  tallyman [command]

Commands:
  list            show tasks (default)
  add             add a task
  done            mark a task done by ID
  edit            open the todo file in an editor
  stats           show counts
  archive         move completed tasks to archive

Help:
  tallyman --help
  tallyman list --help

Examples:
  tallyman
  tallyman add HIGH finish work setup
  tallyman done t-1
  tallyman list sort -p -r
EOF
}
