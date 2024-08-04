-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del
-- 搜索当前目录下的文件, 使用telescope实现
map("n", "<leader>sB", "<cmd>Telescope file_browser path=%:p:h=%:p:h<cr>", { desc = "Browse Files" })

-- 恢复上一个telescope工作区
map(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume Telescopo Workspace" }
)

-- 等效esc
map("i", "<c-d>", "<esc>", { desc = "ESC" })

-- 展示git diff, 使用"sindrets/diffview.nvim"实现
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open Git Diffs" })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Close Git Diffs" })

-- 选择pyth:n venv, 使用"linux-cultist/venv-selector"实现
map("n", "<leader>v", "", { desc = "venv" })
map("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select Python venv" })
map("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", { desc = "Select Last Python venv" })

-- 切换终端
map("n", "<leader>ut", "<cmd>ToggleTerm<cr>", { desc = "Terminal" })
-- map("n", "<leader>uT", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Terminal Vertical" })
map("n", "<leader>`", "<cmd>ToggleTerm<cr>", { desc = "Terminal" })

-- toggle comment
-- unmap({ "n" }, "<c-/>")
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle Comment" })

-- 代码大纲, 使用"aerial"实现
map("n", "<leader>co", "<cmd>AerialToggle<cr>", { desc = "Code Outline" })

-- 树状图撤回
map({ "n", "i" }, "<c-z>", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undotree" })
