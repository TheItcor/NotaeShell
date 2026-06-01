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




# parse_args() - Parse arguments from main() 
#
# nsh <text>   - adds new note
# nsh -h       - prints all commands
# nsh -e [num] - changes the text of the selected note
# nsh -d [num] - deletes the selected note
# nsh -c       - prints configs
#
parse_args() {
    case "$1" in
        -h)
        echo "Help.";;

        -e)
        echo "Edit.";;

        -d)
        echo "Delete.";;

        -c)
        echo "Configuration";;

        *)
        echo "New note";;

    esac
}


# read_file() - Create a /.notaesh in your home directory & read the notes from that
read_file() {
    touch ~/.notaesh
    mapfile -t lines < ~/.notaesh
}

main() {

    # ========= 0. Parse Args =========
    # no args: just print all tasks/notes
    parse_args "$@"

    # ========= 1. Read file with tasks/notes =========
    read_file

    # ========= 2. If args != 0: Execute user's command =========

    # ========= 3. If args == 0: Write task/notes in file =========

    # ========= 4. Print tasks, notes =========
    printf "========= Notash ==========\n"

    for i in "${!lines[@]}"; do
        echo "$((i + 1)): ${lines[$i]}"
    done

    printf "===========================\n"
}

main "$@"
