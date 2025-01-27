# Command Processor Bash Script

This script processes commands listed in a file and executes them sequentially. It is designed to simulate a shell-like interface for handling specific commands defined in the file.

## Features

- **File-based Command Processing**: Reads commands from a specified file (in NNOSLANG format, abbreviated as NL) and executes them.
- **Supported Commands**:
  - `list`: Lists files in the current directory.
  - `list A`: Lists all files, including hidden ones.
  - `list L`: Lists files with detailed information.
  - `list AL` or `list LA`: Combines `list A` and `list L`.
  - `dir <directory>`: Changes to the specified directory (e.g., `dir /home/user`).
  - `wami`: Displays the current working directory.
  - `exit`: Exits the script immediately.
- **Error Handling**: Provides meaningful error messages for invalid commands or missing files.

## Usage

1. Save your commands in a text file (e.g., `commands.nl`), one command per line. Example:
   ```
   list
   list A
   dir /home
   wami
   exit
   ```

2. Run the script, passing the NL file as an argument:
   ```bash
   ./nnoslang.sh commands.nl
   ```

3. The script will execute the commands in the order they are listed in the file.

## Prerequisites

- Ensure the script is executable. You can make it executable with:
  ```bash
  chmod +x nnoslang.sh
  ```
- The command file must exist, be in the NNOSLANG format, and contain valid commands.

## Error Messages

- **File Not Found**: If the specified file does not exist, the script will display:
  ```
  Error: File '<file_name>' not found.
  ```
- **Directory Not Found**: If the `dir` command points to a non-existent directory, the script will display:
  ```
  Error: Directory '<directory>' not found.
  ```
- **Unknown Command**: For unsupported commands, the script will display:
  ```
  command.<command>: Not found
  ```

## Example

Given a file `example_commands.nl` with the following content:
```
list
list A
dir /nonexistent
dir /home
wami
exit
```
Run the script:
```bash
./yourscript.sh example_commands.nl
```
Output:
```bash
<list of files>
<list of all files>
Error: Directory '/nonexistent' not found.
Changed directory to /home
/home
```

