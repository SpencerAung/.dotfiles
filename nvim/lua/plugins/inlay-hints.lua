-- Disable inlay hints: vtsls (TS 5.3.3) crashes on inlayHint requests for some
-- destructuring patterns. Re-enable per-buffer with <leader>uh if a project needs them.
return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
  },
}
