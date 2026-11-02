#!/usr/bin/env bash
#
# Configura la huella digital (python-validity + pam_fprintd) para SDDM
# y, opcionalmente, para sudo.
#
# Uso:
#   sudo ./setup.sh              # SDDM + lockscreen (recomendado)
#   sudo ./setup.sh --with-sudo  # además, huella para sudo (ver README)
#
# Es idempotente: no duplica la línea si ya existe y hace respaldo antes
# de tocar cada archivo PAM.

set -euo pipefail

PAM_LINE='auth sufficient pam_fprintd.so max_tries=1 timeout=10'
WITH_SUDO=0

for arg in "$@"; do
    case "$arg" in
        --with-sudo) WITH_SUDO=1 ;;
        -h|--help)
            sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
            exit 0
            ;;
        *)
            echo "Argumento desconocido: $arg" >&2
            exit 1
            ;;
    esac
done

if [ "$(id -u)" -ne 0 ]; then
    echo "Ejecuta este script con sudo: sudo $0 $*" >&2
    exit 1
fi

if [ ! -e /usr/lib/security/pam_fprintd.so ]; then
    echo "ERROR: falta pam_fprintd.so. Instala primero: paru -S python-validity" >&2
    exit 1
fi

add_pam_line() {
    local file="$1"

    if [ ! -f "$file" ]; then
        echo "  omite $file (no existe)"
        return
    fi

    if grep -q 'pam_fprintd\.so' "$file"; then
        echo "  $file ya configurado"
        return
    fi

    local backup="$file.bak.$(date +%Y%m%d-%H%M%S)"
    cp -a "$file" "$backup"
    sed -i "1i $PAM_LINE" "$file"
    echo "  $file configurado (respaldo: $backup)"
}

echo "Configurando PAM..."
add_pam_line /etc/pam.d/sddm

if [ "$WITH_SUDO" -eq 1 ]; then
    echo
    echo "AVISO: la huella en sudo permite elevar permisos con una lectura."
    echo "       Ver CVE-2024-37408 en el README."
    add_pam_line /etc/pam.d/sudo
fi

echo
echo "Habilitando servicios de suspensión..."
systemctl enable open-fprintd-resume open-fprintd-suspend 2>/dev/null \
    || echo "  aviso: open-fprintd-resume/suspend no están instalados"

echo
echo "Listo. Comprueba con:"
echo "  fprintd-verify && fprintd-list \"\$USER\""
echo "  head -4 /etc/pam.d/sddm"
