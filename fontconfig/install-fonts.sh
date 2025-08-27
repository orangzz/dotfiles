#!/usr/bin/env bash

# mkdir -p ~/.local/share/fonts/JetBrainsMono

# curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz | tar --extract --xz --directory ~/.local/share/fonts/JetBrainsMono

# curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.gz | tar --extract --gzip --directory /Library/Fonts

#curl -L https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.4.8.tar.bz2 | tar --extract --bzip --directory .


set -euo pipefail


readonly SCRIPT_NAME=${0##*/}
readonly TEMP_DIR=/tmp/fonts_$$
readonly SUPPORTED_EXTENSIONS=("ttf" "otf" "woff" "woff2")

readonly MACOS_FONT_DIR="/Library/Fonts"
readonly LINUX_FONT_DIR="/usr/share/fonts/truetype"


readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $*" >&2
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}


cleanup() {
    local exit_code=$?
    [[ -d "$TEMP_DIR" ]] && rm -rf "$TEMP_DIR"
    exit $exit_code
}

trap cleanup EXIT INT TERM





check_tools_requested() {
    local missing_tools=()

    [[ -z $commands[unzip] ]] && missing_tools+=("unzip")
    [[ -z $commands[find] ]] && missing_tools+=("find")

    if [[ ! is_macos &&  -z $commands[fc-cache] ]]; then
        missing_tools+=("fc-cache")
    fi

    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        log_error "Missing required tools: ${missing_tools[*]}"
        return 1
    fi
}




find_font_files() {

    local search_dir="$1"
    local -a find_args=()


    for i in "${!SUPPORTED_EXTENSIONS[@]}"; do
        local ext="${SUPPORTED_EXTENSIONS[i]}"
        if [[ $i -eq 0 ]]; then
            find_args+=("-iname" "*.${ext}")
        else
            find_args+=("-o" "-iname" "*.${ext}")
        fi
    done

    find "$search_dir" -type f \( "${find_args[@]}" \) -print0
}

extract_fonts() {
    local font_folder="$1"
    local extracted_count=0
    while IFS= read -r -d '' zip_file; do
       local filename=${zip_file##*/}
       local filename_without_ext=${filename%.*}
       local extract_dir="$TEMP_DIR/$filename_without_ext"

       if ! unzip -o -q "$zip_file" -d "$extract_dir" 2>/dev/null; then
            log_warn "Failed to extract: $zip_file"
            continue
        fi

        ((extracted_count++))

    done < <(command find $FONT_FOLDER -maxdepth 1 -type f -iname '*.zip' -print0 )

}

install_fonts() {
  local installed_count=0
  local failed_count=0


   log_info "Installation complete: $installed_count installed, $failed_count failed"

    while IFS= read -r -d '' font_file; do
        if install_font_file "$font_file" "$font_dir"; then
            ((installed_count++))
        else
            ((failed_count++))
        fi
    done < <(find_font_files "$TEMP_DIR")

    if [[ $installed_count -eq 0 ]]; then
        log_warn "No fonts were installed"
        return 1
    fi
}


show_usage() {
    cat << EOF
Usage: $SCRIPT_NAME [FONT_FOLDER]

Install fonts from ZIP archives in the specified directory.

Arguments:
    FONT_FOLDER    Directory containing font ZIP files (default: current directory)

Supported font formats: ${SUPPORTED_EXTENSIONS[*]}

Examples:
    $SCRIPT_NAME                    # Install from current directory
    $SCRIPT_NAME ~/Downloads/fonts  # Install from specific directory

EOF
}

main() {
    # Parse arguments
    if [[ $# -gt 1 ]] || [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
        show_usage
        exit 0
    fi

    local font_folder="${1:-.}"



    check_tools_requested || exit 1
    validate_directory "$font_folder" || exit 1

    # Create temporary directory
    mkdir -p "$TEMP_DIR"

    # Execute main workflow
    extract_font_archives "$font_folder"
    install_fonts
    update_font_cache

    log_info "Font installation completed successfully!"
}

if [[ ${BASH_SOURCE[0]} == $0 ]]; then
    main "$@"
fi
