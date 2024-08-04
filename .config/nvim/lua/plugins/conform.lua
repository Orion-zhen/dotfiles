-- 自动格式化

return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      -- autopep8 似乎要比 black 要快一些
      ["python"] = { "autopep8" },
      ["css"] = { "prettier" },
      ["html"] = { "html-lsp" },
      ["htmldjango"] = { "html-lsp" },
    },
  },
}
