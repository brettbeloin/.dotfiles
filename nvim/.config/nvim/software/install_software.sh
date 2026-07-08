#!/usr/bin/env bash

set -e

echo "Neovim Installation Script"
echo "Detecting Linux distribution..."

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Cannot detect distribution"
    exit 1
fi

echo "Detected: $DISTRO"

# Install system packages
echo "Installing system packages..."

if [ "$DISTRO" = "arch" ] || [ "$DISTRO" = "cachyos" ]; then
    sudo pacman -Syu
    sudo pacman -S --noconfirm neovim git gcc clang make cmake tree-sitter npm maven
elif [ "$DISTRO" = "debian" ] || [ "$DISTRO" = "ubuntu" ]; then
    sudo apt update
    sudo apt install -y neovim git gcc clang clang-format make cmake tree-sitter npm maven
elif [ "$DISTRO" = "fedora" ]; then
    sudo dnf install -y neovim git gcc clang clang-tools-extra make cmake tree-sitter npm maven
else
    echo "Unsupported distribution: $DISTRO"
    exit 1
fi

# Install Homebrew for lua-language-server
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install lua-language-server via brew
echo "Installing lua-language-server via Homebrew..."
brew install lua-language-server

# Install Go
echo "Installing Go..."
if ! command -v go &> /dev/null; then
    if [ "$DISTRO" = "arch" ] || [ "$DISTRO" = "cachyos" ]; then
        sudo pacman -S --noconfirm go
    elif [ "$DISTRO" = "debian" ] || [ "$DISTRO" = "ubuntu" ]; then
        sudo apt install -y golang-go
    elif [ "$DISTRO" = "fedora" ]; then
        sudo dnf install -y golang
    fi
fi

# Install Go tools
echo "Installing Go tools..."
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Install Rust and rust-analyzer
echo "Installing Rust..."
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

echo "Installing Rust tools..."
rustup component add rust-analyzer
cargo install bacon

# Install dotnet-sdk
echo "Installing .NET SDK..."
if [ "$DISTRO" = "arch" ] || [ "$DISTRO" = "cachyos" ]; then
    sudo pacman -S --noconfirm dotnet-sdk
elif [ "$DISTRO" = "debian" ] || [ "$DISTRO" = "ubuntu" ]; then
    sudo apt install -y dotnet-sdk-8.0
elif [ "$DISTRO" = "fedora" ]; then
    sudo dnf install -y dotnet-sdk-10.0
fi

# Install Zig (if available in repos, otherwise skip)
echo "Installing Zig language server..."
if [ "$DISTRO" = "arch" ] || [ "$DISTRO" = "cachyos" ]; then
    sudo pacman -S --noconfirm zls 2>/dev/null || echo "zls not available in repos"
elif [ "$DISTRO" = "fedora" ]; then
    sudo dnf install -y zls 2>/dev/null || echo "zls not available in repos"
fi

# Install jdtls
echo "Installing JDTLS..."
if ! command -v jdtls &> /dev/null; then
    if [ "$DISTRO" = "arch" ] || [ "$DISTRO" = "cachyos" ]; then
        if command -v yay &> /dev/null; then
            yay -S --noconfirm jdtls
        else
            echo "yay not found. Install with: yay -S jdtls"
        fi
    else
        JDTLS_VERSION="1.36.0"
        JDTLS_URL="https://github.com/eclipse/eclipse.jdt.ls/releases/download/v${JDTLS_VERSION}/jdtls-${JDTLS_VERSION}-202406271336.tar.gz"
        
        echo "Downloading JDTLS from $JDTLS_URL..."
        if curl -L "$JDTLS_URL" -o /tmp/jdtls.tar.gz; then
            sudo mkdir -p /opt/jdtls
            sudo tar -xzf /tmp/jdtls.tar.gz -C /opt/jdtls
            sudo ln -sf /opt/jdtls/bin/jdtls /usr/local/bin/jdtls
            rm /tmp/jdtls.tar.gz
        else
            echo "Failed to download JDTLS. Install manually from: https://github.com/eclipse/eclipse.jdt.ls/releases"
        fi
    fi
fi

# Install Python packages
echo "Installing Python packages..."
if [ "$DISTRO" = "arch" ] || [ "$DISTRO" = "cachyos" ]; then
    pip install --break-system-packages pyright pylint black ruff
else
    pip install --user pyright pylint black ruff
fi


# Update PATH for Go and Rust
echo ""
echo "Installation complete!"
echo ""
echo "Add these to your shell profile (~/.bashrc, ~/.zshrc, or ~/.config/fish/config.fish):"
echo "export PATH=\"\$HOME/go/bin:\$PATH\""
echo "export PATH=\"\$HOME/.cargo/bin:\$PATH\""
echo ""
echo "Then restart your shell or run: source ~/.bashrc"
