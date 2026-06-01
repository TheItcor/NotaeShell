#!/usr/bin/env bash
# ================================ Notaeshell ================================
#
# Notaeshell (Notaesh) - A bash-script for working with tasks and notes in the terminal.
# Version: 0.1 "Cozy Yurt"
# Started: 31.05.2026
#
# Author: Itcor (TheItcor)
# Main repository: codeberg.org/Itcor/NotaeShell
# Github-mirror: -
# Suggestions and corrections will be extremely welcome.


#
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
    echo "Edit."
}

#
delete_note() {
    echo "Delete."
}

#
edit_config() {
    echo "Configuration"
}

#
add_new_note() {
    echo "New note"
}


print_notes() {
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


# read_file() - Create a /.notaesh in your home directory & read the notes from that
read_file() {
    touch ~/.notaesh
    mapfile -t lines < ~/.notaesh
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
