return
{
    "nvim-neo-tree/neo-tree.nvim",
    priority = 100,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@type neotree.Config?
    opts = {
      auto_open_if_empty = true,
      hijack_netrw = true,
      open_files_do_not_close_tree = true,
	  filesystem = {
   		filtered_items = {
        	hide_gitignored = false,
			hide_dotfiles = false,
        	hide_hidden = false,
        	hide_by_name = {}, 
			hide_by_pattern = {},
        	never_show = {},
        },
      },
    }
}
