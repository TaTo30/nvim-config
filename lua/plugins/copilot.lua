return {
  {
    "github/copilot.vim"
  },
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {
      adapters = {
        http = {
          openai_compatible = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                api_key = "apikey",
                url = "http://127.0.0.1:1234"
              }
            })
          end,
        }
      },
      interactions = {
        chat = {
          adapter = {
            name = "copilot",
            model = "gpt-5-mini",
          },
          tools = {
            ["web_search"] = {
              opts = {
                adapter = "duckduckgo"
              }
            }
          }
        },
      },
      
      prompt_library = {
        markdown = {
          dirs = {
            vim.fn.getcwd() .. "/lua/plugins/prompts"
          }
        }
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
