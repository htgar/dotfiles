set -g fish_greeting
set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    fish_add_path /home/linuxbrew/.linuxbrew/bin
    set -gx PKG_CONFIG_PATH /home/linuxbrew/.linuxbrew/lib/pkgconfig /home/linuxbrew/.linuxbrew/share/pkgconfig $PKG_CONFIG_PATH
    abbr lg 'lazygit'
end

# WSL
function storePathForWindowsTerminal --on-variable PWD
    if test -n "$WT_SESSION"
      printf "\e]9;9;%s\e\\" (wslpath -w "$PWD")
    end
end
