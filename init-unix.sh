# Check if homebrew installed
if command -v brew >/dev/null 2>&1; then
    echo ""
else
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing packages now..."

brew bundle install

mkdir -p ~/.config
ln -sf nvim ~/.config/nvim
ln -sf fish ~/.config/fish 

# sudo chsh -s $(which fish)
