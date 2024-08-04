-- 确保mason已安装特定lsp

return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "clang-format",
      "cmake-language-server",
      "cmakelint",
      "cpplint",
      "cpptools",
      "debugpy",
      "html-lsp",
      "json-lsp",
      "markdownlint",
      "prettier",
      "pyright",
      "python-lsp-server",
      "yaml-language-server",
    },
  },
}
