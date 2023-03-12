local set = vim.keymap.set

vim.g.mapleader = " "

--
set("n", "<leader>e", vim.cmd.Ex)
set("n", "<leader>f", ":LspZeroFormat<CR>")

-- Refactoring
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Center cursor when moving
set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Two clipboards
set("x", "<leader>p", '"_dP')

-- Buffers
set("n", "<leader>x", ":bdelete<CR>")

-- Window navigation
set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

-- Better escape
set("i", "jk", "<ESC>")
set("i", "kj", "<ESC>")

-- Telescope
set("n", "<leader>ff", ':lua require"telescope.builtin".find_files({ hidden = true })<CR>')
set("n", "<leader>fg", ':Telescope live_grep<CR>')
set("n", "<leader>fd", ':Telescope diagnostics<CR>')
set("n", "<leader>fb", ':Telescope buffers<CR>')

set("n", "<leader>u", ":UndotreeToggle<CR>")

-- Sessions
set("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
set("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
set("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})

vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

-- Rest.nvim
set("n", "rr", "<Plug>RestNvim", {})
