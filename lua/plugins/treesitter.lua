return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter",
    opts = {
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
        "c_sharp",
        "rust"
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
    },
  },
}
