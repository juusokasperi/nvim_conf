-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.termguicolors = true
vim.o.mouse = "a"

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = ","

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.relativenumber = true
vim.o.number = true

vim.diagnostic.config({ virtual_text = true })
vim.keymap.set('n', '<Up>', '<C-w>k', {desc = 'Move to split above', silent = true})
vim.keymap.set('n', '<Down>', '<C-w>j', {desc = 'Move to split below', silent = true})
vim.keymap.set('n', '<Left>', '<C-w>h', {desc = 'Move to split to the left', silent = true})
vim.keymap.set('n', '<Right>', '<C-w>l', {desc = 'Move to split to the right', silent = true})
vim.keymap.set('n', '<S-tab>', '<cmd>BufferLineCyclePrev<CR>', {desc = 'Previous buffer', silent = true})
-- vim.keymap.set('n', '<S-q>', '<cmd>BufferLineCycleNext<CR>', {desc = 'Next buffer', silent = true})
vim.keymap.set('n', '``', '<cmd>:Neotree toggle=true reveal=true<CR>', {desc = 'Toggle Neotree', silent = true})
vim.keymap.set('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {desc = 'Open diagnostic messages in a pop-up', silent = true})
vim.keymap.set('n', '<Leader>r', '<cmd>set relativenumber!<CR>', {desc = 'Toggle relative line numbers', silent = true})
vim.keymap.set('n', '<Leader>p', '"0p', {desc = 'Yank from zero register', silent = true})
vim.keymap.set({'n', 'v'}, '<Leader>y', '"+y', {desc = 'Yank to clipboard', silent = true})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	end
})

vim.keymap.set('n', '<Leader>t', function()
  -- Get current buffer's filetype
  local ft = vim.bo.filetype
  if ft == "neo-tree" then
    -- If we're in Neo-tree, go to last non-Neo-tree window
    vim.cmd("wincmd p")
  else
    -- If we're in a code window, focus Neo-tree if open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == "neo-tree" then
        vim.api.nvim_set_current_win(win)
        return
      end
    end
    -- Neo-tree not open? Toggle it
    vim.cmd("Neotree toggle")
  end
end, { desc = "Toggle/focus Neo-tree", silent = true })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
