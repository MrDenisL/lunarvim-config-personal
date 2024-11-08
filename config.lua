-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
lvim.plugins = {
  "mfussenegger/nvim-jdtls",
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

require("lvim.lsp.manager").setup("marksman")

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup {
  {
    name = "prettier",
    filetypes = { "markdown" }, -- Only for Markdown files
  },
}
--Enable formatting on save
--lvim.format_on_save.enabled = true

local linters = require("lvim.lsp.null-ls.linters")
linters.setup {
  {
    name = "markdownlint",
    filetypes = { "markdown" },
  },
}

require("lvim.lsp.manager").setup("ltex", {
  filetypes = { "markdown" }, -- Enable only for Markdown files
  settings = {
    ltex = {
      language = "en-US", -- Set your preferred language
    },
  },
})
lvim.builtin.nvimtree.setup.view.width = 60
-- Indent selected lines with Tab and unindent with Shift-Tab in visual mode
lvim.keys.visual_mode["<Tab>"] = ">gv"
lvim.keys.visual_mode["<S-Tab>"] = "<gv"
-- relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.textwidth = 80 -- Desired line length
--vim.opt.wrap = true -- Enable line wrapping
vim.opt.tabstop = 2      -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2   -- Number of spaces for indentation
vim.opt.expandtab = true -- Converts tabs to spaces
-- clean search pattern
lvim.keys.normal_mode["<leader>n"] = ":nohlsearch<CR>"
lvim.transparent_window = true
lvim.keys = vim.tbl_deep_extend("force", lvim.keys, {
  insert_mode = {
    ["<C-l>"] = "<C-o>$<cmd>silent! LuaSnipUnlinkCurrent<CR>",
    ["<C-j>"] = "<C-o>o<cmd>silent! LuaSnipUnlinkCurrent<CR>",
  }
})

vim.cmd [[
  augroup ReloadMarkdownConfig
    autocmd!
    autocmd BufRead,BufNewFile *.md LvimReload
  augroup END
]]
