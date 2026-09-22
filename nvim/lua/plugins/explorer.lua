return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- dotfiles
          ignored = true, -- gitignored files
          layout = { layout = { position = "right", width = 50 } },
        },
      },
    },
  },
}
