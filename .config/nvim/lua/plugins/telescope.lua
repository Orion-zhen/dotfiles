return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_stragegy = "horizontal",
                    path_display = { "smart" },
                    -- 显示路径的格式, 可选:
                    -- smart: 智能显示
                    -- shorten: 用首字母代表各个文件夹
                    -- absolute: 绝对路径
                    -- tail: 仅文件名
                    layout_config = {
                        horizontal = {
                            preview_width = 0.5,
                            preview_cutoff = 30,
                        },
                        width = { padding = 5 },
                        height = { padding = 5 },
                    },
                },
            })
        end,
    },
}
