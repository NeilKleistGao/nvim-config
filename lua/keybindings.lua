local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

map("n", "<C-b>", ":NvimTreeToggle<CR>", opt)
map("n", "<A-Left>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<A-Right>", ":BufferLineCycleNext<CR>", opt)
map("n", "<C-s>", ":w<CR>", opt)
map("n", "<C-z>", ":undo<CR>", opt)

vim.keymap.set("n", "<C-_>", "gcc", { remap = true, silent = true })

