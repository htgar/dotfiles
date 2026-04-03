vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Package Management
vim.keymap.set("n", "<Leader>pu", "<Cmd>lua vim.pack.update()<CR>", {desc="Update packages"})

vim.pack.add({"https://github.com/nvim-mini/mini.nvim"})

-- UI
vim.cmd("colorscheme catppuccin")
vim.opt.cmdheight = 0
vim.opt.wrap = true

require("vim._core.ui2").enable({})

require("mini.icons").setup()
require("mini.statusline").setup()

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

require("mini.indentscope").setup()

-- Editor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.confirm = true

vim.keymap.set({"n", "x"}, "j", "gj")
vim.keymap.set({"n", "x"}, "k", "gk")

require("mini.pairs").setup()
require("mini.surround").setup()

-- Config Management
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.swapfile = false
vim.o.exrc = true

-- Clipboard
vim.keymap.set({"n", "x"}, "gy", "\"+y", { desc = "Yank to system clipboard", })
vim.keymap.set("n", "gyy", "\"+yy", { desc = "Yank to system clipboard linewise", })
vim.keymap.set("n", "gp", "\"+p", { desc = "Paste from system clipboard", })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})

-- Git
require("mini.diff").setup()

-- Pickers
require("mini.pick").setup()
vim.keymap.set("n", "<Leader>ff", "<Cmd>Pick files<CR>", { desc = "Find Files", })
vim.keymap.set("n", "<Leader>fg", "<Cmd>Pick grep_live<CR>", { desc = "Grep Files", })

require("mini.files").setup()
vim.keymap.set("n", "<Leader>fe", "<Cmd>lua MiniFiles.open()<CR>", { desc = "File Explorer", })

-- Completion and Snippets
vim.opt.ignorecase = true
vim.opt.smartcase = true

require("mini.completion").setup()

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first
    gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

vim.pack.add({"https://github.com/rafamadriz/friendly-snippets"})

-- Tabs and Windows
vim.keymap.set("n", "<Leader>tn",
    function()
        vim.cmd.tabnew()
    end,
    {desc = "Tab New"}
)

-- Treesitter
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})

require("nvim-treesitter").update("all")
require("nvim-treesitter").setup({
  auto_install = true,
})

-- Terminals
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.cmd("startinsert")
    end,
})
vim.keymap.set("n", "<Leader>tt",
    function()
        vim.cmd.tabnew()
        vim.cmd.term()
    end,
    {desc = "Tab Terminal"}
)

-- LSP
vim.pack.add({"https://github.com/neovim/nvim-lspconfig"})
