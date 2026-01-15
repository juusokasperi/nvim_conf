require("config.lazy")
require("mason").setup()
require("mason-lspconfig").setup()
vim.opt.termguicolors = true
vim.lsp.set_log_level("ERROR")
require("tokyonight").setup({
	style = "moon",
	styles = {
		keywords = { italic = false },
	},
	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	on_colors = function(colors)
	colors.hint = colors.orange
	colors.error = "#ff0000"
	end
})
------------------------------------------------------------------------------
vim.cmd[[colorscheme tokyonight-moon]]
