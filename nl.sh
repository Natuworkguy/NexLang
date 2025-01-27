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
    local silent=false

    # Check if -silent is at the end of the command
    if [[ "$command" == *"-silent" ]]; then
        silent=true
        command=${command%-silent} # Remove '-silent' from the command
        command=$(echo "$command" | xargs) # Trim spaces
    fi

    if [[ "$command" == "exit" ]]; then
        $silent || exit 0
    elif [[ "$command" == "list" ]]; then
        $silent || ls
    elif [[ "$command" == "list A" ]]; then
        $silent || ls -a
    elif [[ "$command" == "list L" ]]; then
        $silent || ls -l
    elif [[ "$command" == "list AL" || "$command" == "list LA" ]]; then
        $silent || ls -al
    elif [[ "$command" == dir* ]]; then
        local directory=${command#dir}
        directory=${directory// /}
        directory=${directory//-/}
        if cd "$directory" 2>/dev/null; then
            $silent || echo "Changed directory to $(pwd)"
        else
            $silent || echo "Error: Directory '$directory' not found."
        fi
    elif [[ "$command" == "wami" ]]; then
        $silent || pwd
    elif [[ "$command" == pr* ]]; then
        local message=${command#pr }
        $silent || echo "$message"
    else
        $silent || echo "command.${command// /\.}.${command//-}: Not found"
    fi
}

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <command-file>"
    exit 1
fi

file_path="$1"

process_commands_from_file "$file_path"
