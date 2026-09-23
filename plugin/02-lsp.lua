vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

require('mason').setup({
  registries = {
    'github:mason-org/mason-registry',
    'github:Crashdummyy/mason-registry'
  }
})

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

-- OTHER LSP/LANGUAGES UTILITES
vim.pack.add({
  'https://github.com/seblyng/roslyn.nvim',
  'https://github.com/mrcjkb/rustaceanvim',
  'https://github.com/ray-x/go.nvim'
})

require('go').setup()


local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})
