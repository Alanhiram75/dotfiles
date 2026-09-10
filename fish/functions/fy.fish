function fy
    # fzf busca archivo -> abre yazi en la carpeta del archivo
    set -l file (fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always --line-range=:200 {}' --preview-window '~3')
    if test -n "$file"
        yazi (dirname "$file")
    end
end