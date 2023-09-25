vim.cmd("filetype on")
vim.cmd("set formatoptions+=mb")

-- lazy.nvim の bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
  require("plugins-vscode-nvim")
else
  require("plugins")
  require("filetype")
  require("options")
end

require("bind")
require("default_plugin")
