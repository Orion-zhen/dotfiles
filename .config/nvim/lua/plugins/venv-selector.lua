-- python venv selector

return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        "mfussenegger/nvim-dap-python",
    },
    opts = {
        name = ".venv",
        auto_refresh = true,
    },
    event = "VeryLazy",
}
