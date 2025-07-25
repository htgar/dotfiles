# Set up dotfiles
export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "XDG_CONFIG_HOME"

ln -sf "$PWD/nvim" ~/.config/nvim
ln -sf "$PWD/fish" ~/.config/fish

# Check if homebrew installed
if command -v brew >/dev/null 2>&1; then
    echo ""
else
    echo "Homebrew is not installed. Ensure that it is installed in the container."
    exit
fi

echo "Installing packages now..."

packages=(
    neovim
    ripgrep
    fish
    lazygit
)

for package in "${packages[@]}"
do
    brew install "$package"
done
