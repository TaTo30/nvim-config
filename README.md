# Neovim Configuration - Plug and Play Setup

Complete Neovim setup with LSP, debugging, and completion for Lua, Python, TypeScript, Go, Rust, and C#.

## 🚀 Quick Start

### Step 1: Install External Dependencies (Before Neovim)

#### Required Tools

```bash
# Build essentials and core tools
sudo apt update
sudo apt install -y build-essential git curl wget unzip tar gzip

# Required for Telescope fuzzy finding
sudo apt install -y ripgrep fd-find

# Required for LSP servers and plugins
sudo apt install -y nodejs npm

# Required for Treesitter compilation
sudo apt install -y gcc g++ cmake
```

#### Language Runtimes & SDKs

**Node.js (for TypeScript/JavaScript LSP)**
```bash
# Install Node.js LTS (if not already installed above)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
node --version  # Should be v18+ or newer
```

**Python (for Python LSP)**
```bash
sudo apt install -y python3 python3-pip python3-venv
python3 --version  # Should be 3.8+
```

**Go (for Go development)**
```bash
# Download latest Go version
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

go version  # Verify installation
```

**Rust (for Rust development)**
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustup component add rust-analyzer
rustc --version  # Verify installation
```

**.NET SDK (for C# development)**
```bash
# Add Microsoft package repository
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Install .NET SDK 8.0 (or latest)
sudo apt update
sudo apt install -y dotnet-sdk-8.0

dotnet --version  # Verify installation
```

**Neovim 0.10+**
```bash
# Install latest stable Neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y neovim

# OR build from source for latest version
# git clone https://github.com/neovim/neovim
# cd neovim && make CMAKE_BUILD_TYPE=Release
# sudo make install

nvim --version  # Should be 0.10.0 or newer
```

---

### Step 2: Clone This Configuration

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

# Clone this configuration
git clone <your-repo-url> ~/.config/nvim
cd ~/.config/nvim
```

---

### Step 3: First Launch - Install Neovim Plugins

```bash
# Launch Neovim (plugins will auto-install via lazy.nvim)
nvim
```

On first launch, **lazy.nvim** will automatically:
- Install itself
- Install all configured plugins
- Compile Treesitter parsers

**Wait for all plugins to finish installing** (you'll see a progress window).

---

### Step 4: Install Language Servers & Tools (Inside Neovim)

Once Neovim opens and plugins are installed:

```vim
" Open Mason installer
:Mason

" Inside Mason UI:
" - Press 'i' on these packages to install them:
"   - lua_ls (Lua)
"   - pyright (Python)
"   - ts_ls (TypeScript/JavaScript)
"   - gopls (Go)
"   - omnisharp (C#)
"   - netcoredbg (C# debugger)
" - Press 'q' to close when done

" OR install all at once with:
:MasonInstall lua_ls pyright ts_ls gopls omnisharp netcoredbg
```

Wait for all installations to complete.

---

### Step 5: Verify Everything Works

```vim
" Check LSP servers are installed
:Mason

" Check for any errors
:checkhealth

" Test LSP in a file
:edit test.py
" Enter insert mode and type - you should see completions
" Press 'K' on a symbol - you should see documentation
```

---

## 📦 What's Included

### Language Support

| Language   | LSP Server    | Debugger   | Features                        |
| ---------- | ------------- | ---------- | ------------------------------- |
| Lua        | lua_ls        | -          | Completion, diagnostics, hover  |
| Python     | pyright       | debugpy    | Completion, type checking       |
| TypeScript | ts_ls         | -          | Completion, refactoring         |
| JavaScript | ts_ls         | -          | Completion, refactoring         |
| Go         | gopls         | delve      | Completion, formatting, testing |
| Rust       | rust-analyzer | lldb       | Completion, inlay hints, cargo  |
| C#         | omnisharp     | netcoredbg | Completion, .sln support, debug |

### Plugins & Features

**Core**
- `lazy.nvim` - Plugin manager
- `catppuccin` - Theme
- `lualine.nvim` - Statusline
- `nvim-treesitter` - Syntax highlighting

**LSP & Completion**
- `mason.nvim` + `mason-lspconfig.nvim` - LSP installer
- `nvim-lspconfig` - LSP configurations
- `nvim-cmp` - Autocompletion
  - `cmp-nvim-lsp` - LSP completions
  - `cmp-buffer` - Buffer completions
  - `cmp-path` - Path completions
  - `LuaSnip` - Snippet engine
  - `friendly-snippets` - Snippet collection

**Debugging**
- `nvim-dap` - Debug Adapter Protocol
- `nvim-dap-ui` - Debug UI
- `nvim-dap-virtual-text` - Inline variable values
- `mason-nvim-dap` - Auto-install debuggers

**Utilities**
- `telescope.nvim` - Fuzzy finder
- `gitsigns.nvim` - Git integration
- `nvim-autopairs` - Auto-close brackets
- `copilot.lua` - GitHub Copilot integration

**Language-Specific**
- `rustaceanvim` - Enhanced Rust support
- `go.nvim` - Enhanced Go support (formatting, testing)

---

## ⌨️ Key Bindings

### LSP (available in code files)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `gI` - Go to implementation
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>D` - Type definition
- `<leader>fs` - Document symbols
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>e` - Show diagnostic float
- `<leader>q` - Diagnostic list

### Debugging (C# - netcoredbg)
- `F5` - Start/Continue
- `F10` - Step over
- `F11` - Step into
- `F12` - Step out
- `<leader>b` - Toggle breakpoint
- `<leader>B` - Conditional breakpoint
- `<leader>dt` - Terminate debug session
- `<leader>du` - Toggle debug UI
- `<leader>dr` - Open REPL
- `<leader>dh` - Hover (inspect variable)
- `<leader>df` - Show frames
- `<leader>ds` - Show scopes

### Telescope
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags

### Completion (Insert mode)
- `<C-Space>` - Trigger completion
- `<Tab>` - Next completion / expand snippet
- `<S-Tab>` - Previous completion
- `<CR>` - Confirm selection
- `<C-e>` - Abort completion

---

## 🔧 Troubleshooting

### LSP not starting
```vim
:LspInfo         " Check which LSP servers are attached
:LspLog          " Check LSP logs for errors
:Mason           " Verify language servers are installed
```

### Completions not working
```vim
:checkhealth     " Check for issues
" Make sure you're in insert mode (press 'i')
" Try manually triggering with Ctrl+Space
```

### C# completions not working in multi-project solutions
- Make sure you open Neovim from the folder containing the `.sln` file
- Check `:LspInfo` - root directory should point to the `.sln` folder

### Debugging not working
```vim
:Mason           " Ensure netcoredbg is installed
" Build your project first: :!dotnet build
" Use correct DLL path when debugging
```

---

## 📝 Notes

**Lazy Loading**: Many plugins load on-demand to keep startup fast:
- `nvim-cmp`: Loads when entering insert mode
- `gitsigns`: Loads when opening a file
- Language-specific plugins: Load when opening relevant file types

**Mason**: All LSP servers and debuggers install to `~/.local/share/nvim/mason/`

**Updates**:
```vim
:Lazy sync       " Update all plugins
:Mason           " Update language servers (press 'U' on a package)
:TSUpdate        " Update Treesitter parsers
```

---

## 🎯 Post-Setup: Test Your Installation

**Lua**
```bash
nvim test.lua
# Type: vim. and you should see completions
```

**Python**
```bash
nvim test.py
# Type: import os\nos. and you should see completions
```

**C#**
```bash
cd /path/to/dotnet/solution
nvim SomeFile.cs
# Check :LspInfo shows omnisharp attached
# Type and see completions
# Set breakpoint with <leader>b, press F5 to debug
```

**TypeScript**
```bash
nvim test.ts
# Type: const x: str and you should see completions
```

---

## ✅ Success Checklist

- [ ] All external dependencies installed (Node.js, Python, Go, Rust, .NET)
- [ ] Neovim 0.10+ installed
- [ ] Configuration cloned to `~/.config/nvim`
- [ ] First launch completed (plugins installed)
- [ ] All language servers installed via `:Mason`
- [ ] `:checkhealth` shows no critical errors
- [ ] Tested completion in at least one language
- [ ] (Optional) Tested debugging with netcoredbg

You're all set! 🚀
