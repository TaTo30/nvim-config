vim.api.nvim_create_autocmd('BufReadPre', {
  callback = function()
    vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })
  end
})

vim.api.nvim_create_autocmd('BufNewFile', {
  callback = function()
    vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })
  end
})

vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
})


require('catppuccin').setup({
  flavour = "mocha"
})

require("lualine").setup({
  options = {
    theme = "catppuccin-mocha",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

vim.cmd.colorscheme("catppuccin")
