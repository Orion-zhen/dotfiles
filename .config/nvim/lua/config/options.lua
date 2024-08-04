-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local tabsize = 4

-- 顶端窗口提示
opt.winbar = "%=%m %f"

opt.wrap = true -- 自动折行
opt.relativenumber = false -- 相对行号
opt.guifont = { "Hack Nerd Font" } -- gui字体
opt.list = true
-- opt.listchars = { space = "·" } -- 显示空格
opt.conceallevel = 0 -- 禁用自动隐藏, 比如隐藏掉markdown中的代码块
opt.shiftwidth = tabsize -- 缩进空格数
opt.tabstop = tabsize -- tab
