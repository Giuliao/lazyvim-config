return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        denols = {
          root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
          init_options = {
            enable = true,
            lint = true,
            unstable = true,
          },
        },
        tsserver = {
          root_dir = require("lspconfig.util").root_pattern("package.json"),
          single_file_support = false, -- 仅在 Node.js 项目中启用
        },
      },
      setup = {
        tsserver = function(_, opts)
          -- 禁止在 Deno 项目中启动 tsserver
          opts.root_dir = function()
            return require("lspconfig.util").root_pattern("package.json")(vim.fn.expand("%:p"))
              and not require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")(vim.fn.expand("%:p"))
          end
        end,
      },
    },
  },
}
