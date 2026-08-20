return {
  -- LSP CONFIGURATION
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local mason = vim.fn.stdpath("data") .. "/mason/packages"

      local vue_plugin = mason
        .. "/vue-language-server/node_modules/@vue/language-server"

      vim.lsp.config("vue_ls", {
        capabilities = capabilities,
        filetypes = { "vue" },
      })

      vim.lsp.config("vtsls", {
        capabilities = capabilities,

        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_plugin,
                  languages = { "vue" },
                  configNamespace = "typescript",
                },
              },
            },
          },
        },

        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
        },
      })

      vim.lsp.enable({
        "vue_ls",
        "vtsls",
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    }
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { 
          "mason-org/mason.nvim", 
          opts = {}
        },
        "neovim/nvim-lspconfig",
    },
  },

  -- LANGUAGES UTILITIES
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },


  -- LANGUAGES
  { -- RUST
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },
  { -- GOLANG
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
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
  {
    "seblyng/roslyn.nvim",
    opts = {}
  }
}

