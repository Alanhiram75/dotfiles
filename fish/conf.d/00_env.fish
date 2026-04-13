#                   ---> VARIABLES DE ENTORNO Y PATH <---
#
# Aquí se definen variables de entorno y se añaden directorios al PATH del
# sistema para que Fish pueda encontrar los ejecutables.

# Mejora la visualización de las páginas del manual con 'bat'
set -x MANROFFOPT -c
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Carga configuraciones compatibles desde .fish_profile si existe
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Añade el directorio local de binarios al PATH si existe
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Gruvbox LS_COLORS
set -gx LS_COLORS 'di=00;38;5;243:ln=36:ex=32:pi=31:so=33:bd=33:cd=33:or=31:mi=31:su=37:sg=33:ca=33:tw=33:ow=33'
