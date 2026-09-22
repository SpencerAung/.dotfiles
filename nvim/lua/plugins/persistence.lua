return {
  "folke/persistence.nvim",
  -- init runs during startup (before VimEnter), so this autocmd registers in
  -- time to fire. Registering it from config/autocmds.lua is too late — that
  -- file loads on VeryLazy, after VimEnter has already passed.
  init = function()
    -- Restored buffers come back with no filetype set, so syntax/treesitter
    -- highlighting doesn't attach until a manual :edit. Re-detect filetype for
    -- each restored buffer once the session finishes loading.
    vim.api.nvim_create_autocmd("SessionLoadPost", {
      group = vim.api.nvim_create_augroup("session_ft_fix", { clear = true }),
      callback = function()
        vim.schedule(function()
          for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].filetype == "" and vim.api.nvim_buf_get_name(b) ~= "" then
              vim.api.nvim_buf_call(b, function()
                vim.cmd("filetype detect")
              end)
            end
          end
        end)
      end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("auto_restore_session", { clear = true }),
      nested = true,
      callback = function()
        -- argc 0 = `nvim`; argc 1 + directory = `nvim .` (still a session, not a file).
        local argc = vim.fn.argc()
        if argc == 0 or (argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1) then
          require("persistence").load()
        end
      end,
    })
  end,
}
