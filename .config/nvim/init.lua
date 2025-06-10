require "options"
require "mappings"
require "commands"

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- path where its going to be installed

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local plugins = require "plugins"

require("lazy").setup(plugins, require "lazy_config")

-- Open nvim-tree automatically if nvim is started with a directory argument
-- local function open_nvim_tree(data)
--   -- buffer is a directory
--   local directory = vim.fn.isdirectory(data.file) == 1

--   if not directory then
--     return
--   end

--   -- change to the directory
--   vim.cmd.cd(data.file)

--   -- open the tree
--   require("nvim-tree.api").tree.open()
-- end
local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    -- to file parent
    vim.cmd.cd(vim.fn.fnamemodify(data.file, ":p:h"))
  else
    -- create a new, empty buffer
    vim.cmd.enew()

    -- wipe the directory buffer
    vim.cmd.bw(data.buf)

    -- change to the directory
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = open_nvim_tree,
})

vim.cmd "colorscheme nightfox"
