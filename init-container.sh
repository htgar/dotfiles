# Check if homebrew installed
if command -v brew >/dev/null 2>&1; then
    echo ""
else
    echo "Homebrew is not installed. Please install before proceeding"
    # Optionally offer to install it
    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    exit
fi

echo "Installing packages now..."

packages = (
    neovim
    ripgrep
    fish
    lazygit
)

for package in "${packages}"
do
    brew install "$package"
done


mkdir -p ~/.config
cp -r nvim ~/.config
cp -r fish ~/.config

sudo chsh -s $(which fish)

echo "Dependencies installed, restart shell to see change"
