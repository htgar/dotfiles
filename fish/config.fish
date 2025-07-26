set -g fish_greeting
set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    abbr lg 'lazygit'
end

# WSL
function storePathForWindowsTerminal --on-variable PWD
    if test -n "$WT_SESSION"
      printf "\e]9;9;%s\e\\" (wslpath -w "$PWD")
    end
end
