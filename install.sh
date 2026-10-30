#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "$ROOT_DIR/scripts/lib/common.sh"

PROFILE="minimal"
DRY_RUN=0
NO_GUI=0
SKIP_SYSTEM_UPDATE=0

usage() {
    cat <<'EOF'
Kit-Start — Ubuntu development environment installer

Usage:
  ./install.sh [options]

Options:
  --profile NAME       minimal | python | cpp | backend | full
  --dry-run            Show actions without changing the system
  --no-gui             Skip GUI applications
  --no-system-update   Skip apt-get update
  -h, --help           Show this help
EOF
}

while (($#)); do

    case "$1" in
        --profile)
            (($# >= 2)) || die "--profile requires a value"
            PROFILE="$2"
            shift 2
            ;;


        --dry-run)
            DRY_RUN=1
            shift
            ;;

        --no-gui)
            NO_GUI=1
            shift
            ;;

        --no-system-update)
            SKIP_SYSTEM_UPDATE=1
            shift

            ;;

        -h|--help)
            usage
            exit 0
            ;;

        *)
            die "Unknown option: $1 (use --help)"

            ;;
    esac
done


export KIT_START_DRY_RUN="$DRY_RUN"
export KIT_START_NO_GUI="$NO_GUI"
export KIT_START_ROOT="$ROOT_DIR"

load_profile "$PROFILE"
validate_profile

log_info "Profile: $PROFILE"
log_info "Dry run: $DRY_RUN"
log_info "GUI disabled: $NO_GUI"

check_platform
check_dependencies

if [[ "$DRY_RUN" == "0" ]]; then
    check_sudo
fi

if [[ "$SKIP_SYSTEM_UPDATE" == "0" ]]; then
    run_root apt-get update
fi

# Сначала устанавливаем базовые зависимости.
install_package_file "$ROOT_DIR/packages/base.txt"

# Затем пакеты выбранного профиля.
for package_file in "${PROFILE_PACKAGE_FILES[@]}"; do
    install_package_file "$ROOT_DIR/packages/$package_file"
done

# Запускаем установочные модули.
for module in "${PROFILE_MODULES[@]}"; do

    if [[ "$module" == "gui" && "$KIT_START_NO_GUI" == "1" ]]; then
        log_info "Skipping GUI module"
        continue
    fi


    module_file="$ROOT_DIR/scripts/$module.sh"

    [[ -f "$module_file" ]] || die "Module not found: $module_file"


    source "$module_file"

    function_name="install_${module//-/_}"

    declare -F "$function_name" >/dev/null ||
        die "Module '$module' does not define $function_name"

    "$function_name"

done

log_success "Kit-Start profile '$PROFILE' completed."

if [[ "$DRY_RUN" == "0" ]]; then
    log_info "Some changes may require restarting the terminal session."
fi
