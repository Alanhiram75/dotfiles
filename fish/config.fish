#                       CONFIGURACIÓN PRINCIPAL DE FISH

# Colores de syntax
set fish_color_command normal
set fish_color_param cyan
set fish_color_quote yellow
set fish_color_redirection red
set fish_color_end black

# Autosuggestions legibles sobre fondo oscuro
set fish_color_autosuggestion 8e9aa8
set fish_color_cwd 45a3ff
set fish_color_error ff6b6b

# Java GUI fix (NetBeans, IntelliJ, etc)
set -x _JAVA_AWT_WM_NONREPARENTING 1

# Paths extra
fish_add_path ~/.opencode/bin ~/.cargo/bin

# Carga de módulos desde conf.d
for file in $__fish_config_dir/conf.d/*.fish
    source $file
end

# Zoxide
zoxide init fish | source

# Done notification
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# Mensaje de bienvenida
set -g fish_greeting ""
if status is-interactive
    fastfetch
    starship init fish | source
end
