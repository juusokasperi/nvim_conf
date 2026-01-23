return
{
  "lervag/vimtex",
  lazy = false, -- lazy-loading will disable inverse search
  config = function()
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
    vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
	vim.g.vimtex_view_method = "skim" -- scientific pdf reader for macOS
	vim.g.vimtex_compiler_method = "latexmk"
	vim.api.nvim_set_keymap("n", "\\ll", "<Plug>(vimtex-compile)", {})
	vim.api.nvim_set_keymap("n", "\\lv", "<Plug>(vimtex-view)", {})
	vim.api.nvim_set_keymap("n", "\\le", "<Plug>(vimtex-errors)", {})
	vim.api.nvim_set_keymap("n", "\\li", "<Plug>(vimtex-info)", {})
  end,
  keys = {
    { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
  },
}
