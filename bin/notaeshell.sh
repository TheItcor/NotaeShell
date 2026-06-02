#!/usr/bin/env bash
# ================================ Notaeshell ================================
#
# Notaeshell (Notaesh) - A bash-script for working with tasks and notes in the terminal.
# Version: 0.2 "Warm Yaranga"
# Started: 31.05.2026
#
# Author: Itcor (TheItcor)
# Main repository: codeberg.org/Itcor/NotaeShell
# Github-mirror:   github.com/TheItcor/NotaeShell
# Suggestions and corrections will be extremely welcome.


# ==== Global variables for config ====
# the path to the file where the notes are stored
notes_file_path=~/.notaesh


# read_file() - Create a /.notaesh in your home directory & read the notes from that
read_file() {
    touch "$notes_file_path"
    mapfile -t lines < "$notes_file_path"
}


# Prints flags and info about notaesh
print_help() {
    cat <<EOF
Notaeshell - a humble terminal task manager written in bash.
------------------------------------------------------------
nsh <text>   - adds new note
nsh -h       - prints all commands
nsh -e [num] - changes the text of the selected note
nsh -d [num] - deletes the selected note
nsh -c       - prints configs
------------------------------------------------------------
Main repository: codeberg.org/Itcor/NotaeShell
EOF
}

#
edit_note() {
    local number_line="$1"
    local new_text
    read -p "New text for note: " new_text

    # Catching the wrong input
    if [[ -z "$number_line" ]]; then
        echo "[ERR]: line number not specified."
        return 1
    fi
    if ! [[ "$number_line" =~ ^[0-9]+$ ]]; then
        echo "[ERR]: The second argument must be a number."
        return 1
    fi

    sed -i "${number_line}c\\${new_text}" "$notes_file_path"
    read_file
    echo "nsh: $number_line note was edited."
}

#
delete_note() {
    local number_line="$1"

    # Catching the wrong input
    if [[ -z "$number_line" ]]; then
        echo "[ERR]: line number not specified."
        return 1
    fi
    if ! [[ "$number_line" =~ ^[0-9]+$ ]]; then
        echo "[ERR]: The second argument must be a number."
        return 1
    fi

    sed -i "${number_line}d" "$notes_file_path"
    read_file
    echo "nsh: $number_line note was deleted."
}

#
edit_config() {
    echo "Configuration"
}

#
add_new_note() {
    local new_note="$*"

    echo "$new_note" >> "$notes_file_path"
    read_file
    echo "nsh: new note wad added."
}


print_notes() {

    if [ -z "${lines[0]}" ]; then
        echo "nsh: there are no notes."
        exit 1
    fi

    printf "========= Notash ==========\n"

    for i in "${!lines[@]}"; do
        echo "$((i + 1)): ${lines[$i]}"
    done

    printf "===========================\n"
}

# parse_args() - Parse arguments from main()
#
# nsh <text>   - adds new note
# nsh -h       - prints all commands
# nsh -e [num] - changes the text of the selected note
# nsh -d [num] - deletes the selected note
# nsh -c       - prints configs
#
parse_args() {

    [ $# -eq 0 ] && print_notes "$@" && return 0 # if no args - return 0

    case "$1" in
        -h)
        print_help;;

        -e)
        edit_note "$2"
        print_notes "$@";;

        -d)
        delete_note "$2"
        print_notes "$@";;

        -c)
        edit_config;;

        *)
        add_new_note "$@"
        print_notes "$@";;

    esac
}



main() {

    # ========= 0. Read file with tasks/notes =========
    read_file

    # ========= 1. Parse Args =========
    # no args: just print all tasks/notes
    parse_args "$@"

    # ========= 2. If args != 0: Execute user's command =========

    # ========= 3. If args == 0: Write task/notes in file =========

    # ========= 4. Print tasks, notes =========
    # moved to parse_args()
}

main "$@"
