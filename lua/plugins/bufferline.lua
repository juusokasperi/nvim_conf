return {
  'akinsho/bufferline.nvim',
  branch = "main",
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = false,
  priority = 1000,
  config = function()
    -- make sure truecolor is enabled
    vim.o.termguicolors = true

    require('bufferline').setup({
      options = {
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = 'slope',
      },
    })
  end
}
