return {
  {
    "github/copilot.vim"
  },
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {
      interactions = {
        chat = {
          adapter = "copilot",
          model = "gpt-5-mini",
        },
        inline = {
          adapter = "copilot",
          model = "gpt-5-mini"
        }
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
