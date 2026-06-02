return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "python",
          "json",
          "html",
          "css",
          "markdown",
          "markdown_inline",
          "bash",
        },
        auto_install = true,
      })
    end,
  },
}
