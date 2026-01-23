return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "texlab", "gopls" },
      })
    end,
  },
  {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/clangd"

    vim.lsp.config("clangd", {
      cmd = {
        mason_bin,
        "--background-index",
        "--clang-tidy",
        "--log=error",
		"--query-driver=/usr/bin/clang,/usr/bin/clang++,/usr/bin/cc",
      },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_markers = { ".git", "compile_commands.json", ".clangd" },
    })

	vim.lsp.config("texlab", {
		filetypes = { "tex", "plaintex", "bib" },
		settings = {
			texlab = {
				diagnostics = {
					ignoredPatterns = {
						"Overfull",
						"Underfull",
					},
				},
			},
		},
	})

	vim.lsp.enable("texlab")
    vim.lsp.enable("clangd")
	vim.lsp.enable("gopls")

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

		if client.name == "texlab" then
			vim.keymap.set("n", "<Leader>K", "<plug>(vimtex-doc-package)", { desc = "VimTex: package docs", buffer = args.buf, silent = true })
		end
        
        local tb = require("telescope.builtin")
         local opts = { buffer = args.buf }
          
         vim.keymap.set("n", "gd", tb.lsp_definitions, { desc = "Go to definition", buffer = args.buf })
         vim.keymap.set("n", "gr", tb.lsp_references, { desc = "References", buffer = args.buf })
         vim.keymap.set("n", "gi", tb.lsp_implementations, { desc = "Implementations", buffer = args.buf })
         vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = args.buf })
      end,
    })
  end,
  },
}
