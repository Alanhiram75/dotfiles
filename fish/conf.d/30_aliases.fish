#                              ---> ALIAS <---
#
# Atajos para comandos largos o de uso frecuente.

# =============================================
# 1.           LISTADOS (EZA)
# =============================================
# Aliases/shortcuts para reemplazar 'ls' con 'eza'
alias ls='eza -1 --group-directories-first --icons=always --color=always --no-user --no-permissions --no-time --no-filesize | sed "s/^/ - /"' # <-- Listado estándar con eza
alias la='eza --classify=auto --color=always --group-directories-first --sort=extension -A --icons' # <-- Listado con iconos y ocultos
alias lt='eza --tree --level=5 --group-directories-first --icons --no-user --no-permissions --no-time --no-filesize'
alias l\.="eza -a | grep -e '^\.'"                                                                  # <-- Solo archivos/dirs ocultos 

# =============================================
# 2.          SISTEMA Y PAQUETES
# =============================================
# Aliases/shortcuts para tareas comunes del sistema
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg" # <-- Regenerar configuración de GRUB
alias fixpacman="sudo rm /var/lib/pacman/db.lck"         # <-- Eliminar bloqueo de pacman
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'          # <-- Limpiar dependencias huérfanas
alias jctl="journalctl -p 3 -xb"                         # <-- Ver logs importantes del sistema
alias update='yay && flatpak update'                     # <-- Actualizar todos los paquetes
alias sonido="pavucontrol"                               # <-- Configuración de sonido
alias syu='sudo pacman -Syu'                             # <-- Actualizar el sistema con pacman
alias mirrors='sudo reflector --latest 30 --protocol https --sort rate --save /etc/pacman.d/mirrorlist' # ↴
# ↳ Selecciona los 30 servidores https más actualizados, organizados por velocidad de descarga, reescribe en pacman.d/mirrorlist ↲

# =============================================
# 3.                NAVEGACIÓN
# =============================================
# Aliases/shortcuts para moverse entre directorios
alias ..='cd ..'                 # <-- Subir un directorio
alias ...='cd ../..'             # <-- Subir dos directorios
alias ....='cd ../../..'         # <-- Subir tres directorios
alias .....='cd ../../../..'     # <-- Subir cuatro directorios
alias ......='cd ../../../../..' # <-- Subir cinco directorios
alias cdq='prevd'                # <-- Ir al directorio anterior en el stack
alias cda='nextd'                # <-- Ir al siguiente directorio en el stack
alias cls='clear'                # <-- Limpiar pantalla
alias sa='exit'                  # <-- Salir de la shell

# =============================================
# 4.                 ARCHIVOS
# =============================================
# Comandos para manipulación de archivos
alias untar='tar -xf'      # <-- Descomprimir un archivo .tar, sin eliminar el .tar original
alias tarnow='tar -acvf '  # <-- Crear un archivo .tar usando comprensión automática
alias targnow='tar -czvf ' # <-- Crear un archivo .tar usando gzip como comprensión
alias ungz="gunzip"        # <-- Descomprimir archivos .gz
alias wget='wget -c '      # <-- Continuar descargas interrumpidas automáticamente
alias zipnow='7z a '       # <-- Crear un archivo .7z usando 7zip
alias unzip='7z x'         # <-- Descomprimir .zip usando la heramienta de 7zip

# =============================================
# 5.     HERRAMIENTAS Y ACCESOS DIRECTOS
# =============================================
# Accesos rápidos a herramientas externas
alias icat='kitten icat' # <-- Visor rápida y nativo de imágenes usando la terminal de Kitty
alias tub='pipes-rs'     # <-- Generación fantástica y atractiva de tuberías (usando Pipes-RS) en la terminal
alias lg='lazygit'       # <-- Uso rápido de 'lazygit'
alias py='python3'       # <-- Uso rápido de 'python3'
alias n='yazi'           # <-- Uso rápido de 'yazi'
alias po='poweroff'      # <-- Apagar el sistema
alias ss='systemctl suspend; and exit' # <-- Suspender el sistema y cerrar terminal
alias lc='ollama launch claude' # <-- Lanzar Claude con Ollama
alias nlc='cd ~/notes; and lc'  # <-- Ir a notes y lanzar Claude
alias postgrestart='sudo systemctl start postgresql.service'  # <-- Inicializar PostgreSQL
alias ui='cd inir && ./setup'                                  # <-- Update inir
# =============================================
# 6.      INFORMACIÓN DEL SISTEMA
# =============================================
# Aliases/shortcuts para inspección del sistema
alias psmem='ps auxf | sort -nr -k 4'                                         # <-- Procesos ordenados por RAM
alias psmem10='ps auxf | sort -nr -k 4 | head -10'                            # <-- Top 10 por RAM
alias hw='hwinfo --short'                                                     # <-- Resumen de hardware
alias big="expac -H M '%m\t%n' | sort -h | nl"                                # <-- Paquetes más pesados
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'                            # <-- Contar paquetes -git
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # <-- Paquetes recientes
alias fsh='fastfetch'                                                         # <-- Información rápida del sistema
alias bigr='sudo du -h --max-depth=1 / | sort -hr'                            # <-- Uso de disco en /

# =============================================
# 7.         RED Y TEXTO
# =============================================
# Aliases/shortcuts para utilidades de texto y red
alias dir='dir --color=auto'     # <-- Listado con color
alias vdir='vdir --color=auto'   # <-- Listado detallado con color
alias grep='grep --color=auto'   # <-- Búsqueda con color
alias fgrep='fgrep --color=auto' # <-- Búsqueda fija con color
alias egrep='egrep --color=auto' # <-- Búsqueda extendida con color
alias tb='nc termbin.com 9999'   # <-- Enviar texto a termbin

# =============================================
# 8.                 GIT
# =============================================
# Aliases/shortcuts para un workflow más fluido usando git 
alias gi='git init'               # <-- Inicializar un nuevo repositorio Git
alias gs='git status'             # <-- Ver el estado del repositorio
alias ga='git add'                # <-- Añadir archivos al staging
alias gaa='git add --all'         # <-- Añadir todos los archivos al staging
alias gc='git commit -m'          # <-- Hacer commit con mensaje
alias glo='git log --oneline'     # <-- Ver historial de commits en una línea
alias glo5='git log --oneline -5' # <-- Ver últimos 5 commits en una línea
alias gco='git checkout'          # <-- Cambiar de rama o versión
alias gbr='git branch'            # <-- Listar, crear o eliminar ramas
alias gp='git push'               # <-- Subir cambios al repositorio remoto