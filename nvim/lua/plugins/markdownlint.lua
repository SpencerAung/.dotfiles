-- nvim-lint pipes markdown over stdin (`markdownlint-cli2 -`), so the linter
-- resolves config from cwd, not the file — meaning ~/.markdownlint.json often
-- isn't found. Point it at that config explicitly.
return {
  "mfussenegger/nvim-lint",
  opts = function()
    local lint = require("lint")
    lint.linters["markdownlint-cli2"] = vim.tbl_deep_extend("force", lint.linters["markdownlint-cli2"], {
      args = { "--config", vim.fn.expand("~/.markdownlint.json"), "-" },
    })
  end,
}
