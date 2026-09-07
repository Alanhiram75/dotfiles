#!/usr/bin/env bash
set -euo pipefail

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"

count_repos="$(pacman -Qn 2>/dev/null | wc -l)"
count_aur="$(pacman -Qm 2>/dev/null | wc -l)"
count_flatpak="$(flatpak list --app 2>/dev/null | wc -l || true)"

printf '%s' "$count_repos" > "$cache_dir/pkg-count-pacman"
printf '%s' "$count_aur" > "$cache_dir/pkg-count-aur"
printf '%s' "$count_flatpak" > "$cache_dir/pkg-count-flatpak"