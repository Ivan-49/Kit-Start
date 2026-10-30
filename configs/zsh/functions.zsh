# Create directory and enter it.

mkcd() {
    mkdir -p -- "$1" && cd -- "$1"
}


# Extract archives.

extract() {


    if [[ ! -f "$1" ]]; then
        echo "File not found: $1" >&2
        return 1
    fi

    case "$1" in

        *.tar.gz|*.tgz)
            tar -xzf "$1"
            ;;

        *.tar.xz|*.txz)
            tar -xJf "$1"
            ;;


        *.tar.bz2|*.tbz2)
            tar -xjf "$1"
            ;;


        *.zip)
            unzip "$1"
            ;;

        *.gz)
            gunzip "$1"
            ;;

        *.xz)
            unxz "$1"
            ;;


        *)
            echo "Unsupported archive: $1" >&2
            return 1
            ;;

    esac
}
