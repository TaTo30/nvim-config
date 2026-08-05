return {
  -- LSP CONFIGURATION
  {
    "neovim/nvim-lspconfig"
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
          opts = {
            ensure_installed = {
              "lua_ls",
              "pyright",
              "ts_ls",
              "roslyn"
            },
          } 
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
  }
}

