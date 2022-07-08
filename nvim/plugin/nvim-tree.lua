-- examples for your init.lua

-- empty setup using defaults
require("nvim-tree").setup({
  view = {
    side = "left",
    centralize_selection = true,
    adaptive_size = true,
    preserve_window_proportions = true,
  }
})

vim.api.nvim_set_keymap("n", ",n", "<cmd>NvimTreeFindFileToggle<cr>",
  {silent = true, noremap = true }
)
