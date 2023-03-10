local m = vim.keymap.set

-- clear highlight
m("n", "<leader>h", "<cmd>nohlsearch<cr>", {})

-- add empty line
m("n", "<space>oo", "o<esc>k", { noremap = true })
m("n", "<space>O", "O<esc>j", { noremap = true })

-- move selection up and down
m("v", "J", ":m '>+1<cr>gv=gv")
m("v", "K", ":m '<-2<cr>gv=gv")

-- do not exit visual mode after shifting
m("v", "<", "<gv", { noremap = true})
m("v", ">", ">gv", { noremap = true})

-- keep cursor in the middle of the screen
m("n", "<c-d>", "<c-d>zz")
m("n", "<c-u>", "<c-u>zz")
m("n", "n", "nzzzv")
m("n", "N", "Nzzzv")

-- greatest remap ever
m("x", "<leader>p", [["_dP]])

-- select quotes with trimmed spaces
m({"v", "o"}, 'a"', '2i"', { noremap = true})
m({"v", "o"}, "a'", "2i'", { noremap = true})
m({"v", "o"}, "a`", "2i`", { noremap = true})

-- telescope
m("n", "<leader>ff", "<cmd>Telescope find_files previewer=false theme=get_dropdown<cr>", { noremap = true })
m("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
m("n", "<leader>fb", "<cmd>Telescope file_browser previewer=false theme=get_dropdown<cr>", { noremap = true })

-- bufferline
m("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", { noremap = true })
m("n", "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", { noremap = true })
m("n", "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", { noremap = true })
m("n", "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", { noremap = true })
m("n", "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", { noremap = true })
m("n", "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", { noremap = true })
m("n", "<leader>b7", "<cmd>BufferLineGoToBuffer 7<cr>", { noremap = true })
m("n", "<leader>b8", "<cmd>BufferLineGoToBuffer 8<cr>", { noremap = true })
m("n", "<leader>b9", "<cmd>BufferLineGoToBuffer 9<cr>", { noremap = true })
m("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { noremap = true })
m("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", { noremap = true })
m("n", "<leader>bh", "<cmd>BufferLinePick<cr>", { noremap = true })
m("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true })

-- navigator
m("n", "<c-h>", "<cmd>lua require('Navigator').left()<cr>", { noremap = true })
m("n", "<c-j>", "<cmd>lua require('Navigator').down()<cr>", { noremap = true })
m("n", "<c-k>", "<cmd>lua require('Navigator').up()<cr>", { noremap = true })
m("n", "<c-l>", "<cmd>lua require('Navigator').right()<cr>", { noremap = true})
