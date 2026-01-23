return
{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "cpp", "go", "gomod", "gowork", "gosum", "lua" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
