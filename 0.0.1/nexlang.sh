#!/bin/bash

process_commands_from_file() {
    local file_path="$1"

    if [[ ! -f "$file_path" ]]; then
        echo "Error: File '$file_path' not found."
        exit 1
    fi

    while IFS= read -r line; do
        execute_command "$line"
    done < "$file_path"
}

execute_command() {
    local command="$1"

    if [[ "$command" == "exit" ]]; then
        exit 0
    elif [[ "$command" == "list" ]]; then
        ls
    elif [[ "$command" == "list A" ]]; then
        ls -a
    elif [[ "$command" == "list L" ]]; then
        ls -l
    elif [[ "$command" == "list AL" || "$command" == "list LA" ]]; then
        ls -al
    elif [[ "$command" == dir* ]]; then
        local directory=${command#dir}
        directory=${directory// /}
        directory=${directory//-/}
        if cd "$directory" 2>/dev/null; then
            echo "Changed directory to $(pwd)"
        else
            echo "Error: Directory '$directory' not found."
        fi
    elif [[ "$command" == "wami" ]]; then
        pwd
    else
        echo "command.${command// /\.}.${command//-}: Not found"
    fi
}

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <command-file>"
    exit 1
fi

file_path="$1"

process_commands_from_file "$file_path"

