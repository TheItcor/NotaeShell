#!/usr/bin/env bash

# Notaeshell - A bash-script for working with tasks and notes in the terminal.
# Version: 0.1 beta
# Started: 31.05.2026
#
# Author: Itcor (TheItcor)
# Main repository: codeberg.org/Itcor/Notaesh
# Github-mirror: -
# Suggestions and corrections will be extremely welcome.

parse_args() {
    POSITIONAL_ARGS=()

}



main() {

    # ========= 0. Parse Args =========
    # no args: just print all tasks/notes
    parse_args "$@"

    # ========= 1. Read file with tasks/notes =========

    # ========= 2. If args != 0: Execute user's command =========

    # ========= 3. If args != 0: Write task/notes in file =========

    # ========= 4. Print tasks, notes =========
    printf "========= Notash ==========\n"

    printf "===========================\n"
}

main "$@"
