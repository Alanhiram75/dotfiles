#                       CONFIGURACIÓN PRINCIPAL DE FISH

# Colores
set fish_color_command normal
set fish_color_param cyan
set fish_color_quote yellow
set fish_color_redirection red
set fish_color_end black

# Java GUI fix (NetBeans, IntelliJ, etc)
set -x _JAVA_AWT_WM_NONREPARENTING 1

# Carga de módulos desde conf.d
for file in $__fish_config_dir/conf.d/*.fish
    source $file
end

# Mensaje de bienvenida
set -g fish_greeting ""
if status is-interactive
    fastfetch
    starship init fish | source
end
