# Neovim Configuration

## Plugins

### Always Loaded (lazy=false)
- lazy.nvim (plugin manager)
- catppuccin (theme) 
- lualine.nvim (statusline)
- nvim-treesitter (syntax highlighting)
- rustaceanvim (Rust support)

### Lazy-Loaded (load on events)
- mason.nvim + mason-lspconfig.nvim
- nvim-lspconfig
- **nvim-cmp** (loads on `InsertEnter`) 
  - LuaSnip + friendly-snippets
  - **cmp-buffer** + **cmp-path** + **cmp_luasnip** + **cmp-nvim-lsp** (load with nvim-cmp)
- telescope.nvim + telescope-fzf-native.nvim
- csharp.nvim (with nvim-dap + structlog.nvim)
- **gitsigns.nvim** (loads on `BufReadPre`, `BufNewFile`)
- nvim-web-devicons

> **Important:** Lazy-loaded plugins will show as "Not Loaded" in `:Lazy` until you trigger their events:
> - **nvim-cmp and completion sources**: Press `i` to enter insert mode
> - **gitsigns.nvim**: Open any file
> 
> This is **correct behavior** - it makes Neovim start faster!

## Dependencies (Ubuntu)

```bash
# Node.js (for ts_ls, pyright LSP servers)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs

# Python
sudo apt install python3 python3-pip

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer

# .NET SDK
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install dotnet-sdk-8.0

# Optional: Telescope enhancements
sudo apt install ripgrep fd-find
```
