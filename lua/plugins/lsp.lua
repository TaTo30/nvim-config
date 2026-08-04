return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- mason-lspconfig v2: uses automatic_enable + vim.lsp.enable() instead of setup_handlers
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "omnisharp", "gopls" },
        -- Handlers to configure servers (v2 API)
        handlers = {
          -- Default handler for all servers
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
          end,
          -- Custom handler for omnisharp to handle multi-project workspaces
          ["omnisharp"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.omnisharp.setup({
              cmd = { vim.fn.stdpath("data") .. "/mason/bin/OmniSharp" },
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              -- Prioritize .sln files for multi-project workspaces
              root_dir = function(fname)
                local util = require("lspconfig.util")
                -- First try to find .sln in parent directories (for multi-project solutions)
                local sln = util.root_pattern("*.sln")(fname)
                if sln then
                  return sln
                end
                -- Fall back to .csproj or .git
                return util.root_pattern("*.csproj", ".git")(fname)
              end,
              settings = {
                FormattingOptions = {
                  EnableEditorConfigSupport = true,
                  OrganizeImports = true,
                },
                RoslynExtensionsOptions = {
                  EnableAnalyzersSupport = true,
                  EnableImportCompletion = true,
                  AnalyzeOpenDocumentsOnly = false,
                },
                Sdk = {
                  IncludePrereleases = true,
                },
              },
            })
          end,
          -- Custom handler for lua_ls with Neovim-aware settings
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  workspace = { checkThirdParty = false },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- nvim-lspconfig (v1.x): registers default server configs via vim.lsp.config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Diagnostic keymaps (global)
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic float" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

      -- LSP keymaps via LspAttach autocmd
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gr", vim.lsp.buf.references, "Go to references")
          map("gI", vim.lsp.buf.implementation, "Go to implementation")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
          map("<leader>fs", require("telescope.builtin").lsp_document_symbols, "Document symbols")
        end,
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
    -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}

