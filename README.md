# tallyman
A to-do script for the Fedora CLI. 

Tallyman stores tasks in a **Markdown table**, renders them with **glow**.

Works in and out of flatpak integrated terminals!

## Install

1. Clone this repository
2. Run the `./install.sh` script
3. Try running `tallyman -h` in a terminal
4. You may now delete safely this repository

> [!TIP]
> The script is stored in `~/.local/bin/tallyman`
> 
> The libraries in `~/.local/lib/tallyman`
> 
> The glow style in `~/.config/glow/styles`
> 
> You may change any of these values in `./install/sh`

## Usage

### `tallyman --help`
```

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
  ```

---

### `tallyman list --help`
```
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

```

---

## File format

Tasks are stored as a Markdown table:

ID | Done | Date | Priority | Description
-:|:-:|:-|:-|:-
ait-1 | [ ] | 2026-01-04 | HIGH | An important task!
~~aft-1~~ | [x] | ~~2026-01-03~~ | ~~LOW~~ | ~~A finished task~~