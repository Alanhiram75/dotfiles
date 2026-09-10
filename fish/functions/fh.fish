function fh
    # fzf busca archivo -> lo abre directo con helix
    set -l file (fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always --line-range=:200 {}' --preview-window '~3')
    if test -n "$file"
        helix "$file"
    end
end