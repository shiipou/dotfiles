local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent

-- nvimtree
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")
map("n", "<C-h>", "<cmd> NvimTreeFocus <CR>")

-- telescope
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")

-- bufferline, cycle buffers
map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<C-q>", "<cmd> bd <CR>")

-- comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })

-- format
map("n", "<leader>fm", function()
  require("conform").format()
end)

-- term
map("n", "<leader>tv", "<cmd> horizontal botright term <CR>")
map("n", "<leader>th", "<cmd> vertical botright term <CR>")

-- resize 
map('n', '<A-j>', '<C-w>-', { noremap = true })
map('n', '<A-k>', '<C-w>+', { noremap = true })
map('n', '<A-h>', '<C-w>>', { noremap = true })
map('n', '<A-l>', '<C-w><', { noremap = true })

-- move current line
map('n', '<A-Up>', ':m .-2<CR>', { noremap = true })
map('n', '<A-Down>', ':m .+1<CR>', { noremap = true })

-- toggle relative numbers
map('n', '<leader>rn', ':set relativenumber! <CR>')
