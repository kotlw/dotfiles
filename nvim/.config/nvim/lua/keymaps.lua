local m = vim.keymap.set

-- clear highlight
m("n", "<leader>h", "<cmd>nohlsearch<cr>")

-- add empty line
m("n", "<space>oo", "o<esc>k")
m("n", "<space>O", "O<esc>j")

-- move selection up and down
m("v", "J", "xp`[V`]")
m("v", "K", "xkP`[V`]")

-- do not exit visual mode after shifting
m("v", "<", "<gv")
m("v", ">", ">gv")

-- keep cursor in the middle of the screen
m("n", "<c-d>", "<c-d>zz")
m("n", "<c-u>", "<c-u>zz")
m("n", "n", "nzzzv")
m("n", "N", "Nzzzv")

-- greatest remap ever
m("x", "<leader>p", [["_dP]])

-- select quotes with trimmed spaces
m({"v", "o"}, 'a"', '2i"')
m({"v", "o"}, "a'", "2i'")
m({"v", "o"}, "a`", "2i`")

-- telescope
m("n", "<leader>ff", "<cmd>Telescope find_files previewer=false theme=get_dropdown<cr>")
m("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
m("n", "<leader>fb", "<cmd>Telescope file_browser previewer=false theme=get_dropdown<cr>")

-- bufferline
m("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>")
m("n", "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>")
m("n", "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>")
m("n", "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>")
m("n", "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>")
m("n", "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>")
m("n", "<leader>b7", "<cmd>BufferLineGoToBuffer 7<cr>")
m("n", "<leader>b8", "<cmd>BufferLineGoToBuffer 8<cr>")
m("n", "<leader>b9", "<cmd>BufferLineGoToBuffer 9<cr>")
m("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>")
m("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>")
m("n", "<leader>bh", "<cmd>BufferLinePick<cr>")
m("n", "<leader>bd", "<cmd>bd<cr>")

-- navigator
m("n", "<c-h>", "<cmd>lua require('Navigator').left()<cr>")
m("n", "<c-j>", "<cmd>lua require('Navigator').down()<cr>")
m("n", "<c-k>", "<cmd>lua require('Navigator').up()<cr>")
m("n", "<c-l>", "<cmd>lua require('Navigator').right()<cr>")

-- dap
-- m("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", { noremap = true })
m("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>")
m("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>")
m("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>")
m("n", "<leader>dp", "<cmd>lua require('dap').step_out()<cr>")
m("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>")
m("n", "<leader>ds", "<cmd>lua require('dap').stop()<cr>")
m("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<cr>")
m("n", "<leader>dk", "<cmd>lua require('dap').up()<cr>")
m("n", "<leader>dj", "<cmd>lua require('dap').down()<cr>")
m("n", "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<cr>")
m("n", "<leader>d?", "<cmd>lua local w=require('dap.ui.widgets'); w.centered_float(w.scopes)<cr>")
