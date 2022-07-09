-- examples for your init.lua

-- Fix opening on right side when opening file for the first time
vim.opt.splitright = true


require("nvim-tree").setup({
  view = {
    side = "left",
    centralize_selection = true,
    adaptive_size = true,
    preserve_window_proportions = true,
    mappings = {
      list = {
        { key = "i", action = "split" },
        { key = "s", action = "vsplit" },
      }
    }
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      }
    }
  }
})

vim.api.nvim_set_keymap("n", ",n", "<cmd>NvimTreeFindFileToggle<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap("n", ",f", "<cmd>NvimTreeFocus<cr>",
  { silent = true, noremap = true }
)
