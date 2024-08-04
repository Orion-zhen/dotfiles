local func = require("vim.func")
-- 自动补全

return {
  -- 代码补全
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      {
        "Exafunction/codeium.nvim",
        config = function()
          require("codeium").setup({})
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      -- local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      cmp.setup({
        snippet = {
          expand = function(args)
            -- luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          -- { name = "luasnip" },
          { name = "buffer" },
          { name = "treesitter" },
          { name = "path" },
          -- { name = "codeium" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            symbol_map = { Codeium = "" },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-.>"] = cmp.mapping.select_prev_item(),
          ["<C-,>"] = cmp.mapping.select_next_item(),
          -- ["<C-l>"] = cmp.mapping.complete(),
          -- ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
      })
    end,
  },
  -- 命令补全
  {
    "hrsh7th/cmp-cmdline",
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(":", {
        -- 更改选中按键为<cr>
        mapping = cmp.mapping.preset.cmdline({
          ["<cr>"] = {
            c = cmp.mapping.confirm({ select = false }),
          },
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
