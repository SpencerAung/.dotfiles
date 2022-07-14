vim.opt.termguicolors = true
require('bufferline').setup({
  options = {
    -- mode = "buffers",
    numbers = "buffer_id",
    always_show_bufferline = true,
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
  }
})
