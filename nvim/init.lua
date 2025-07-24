-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
	'git', 'clone', '--filter=blob:none',
	'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
-- TODO replace with vim.pack once nvim 0.12 is out
require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Colorscheme
add({source = 'catppuccin/nvim'})
vim.cmd('colorscheme catppuccin')

-- Basic Setup
require('mini.basics').setup()
vim.opt.cmdheight = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 4
vim.opt.autoindent = true
vim.opt.relativenumber = true
vim.opt.confirm = true
vim.opt.wrap = true

-- Notifications
require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()

-- UI
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.icons').setup()
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {

    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

    -- TODO Replace with inbuilt lsp color swatches in nvim 0.12
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

-- Editor
require('mini.ai').setup()
require('mini.pairs').setup()
require('mini.surround').setup()

-- Git
require('mini.diff').setup()

-- Treesitter
add({
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'master',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = {
        enable = true,
    }
})

-- Pickers
require('mini.pick').setup()

-- Buffers
vim.keymap.set('n', '<Leader>bl', '<cmd>Pick buffers<cr>', {desc='Buffer List'})
vim.keymap.set('n', '<Leader>bd', '<cmd>bdelete<cr>', {desc='Buffer Delete'})
vim.keymap.set('n', '<Leader>bn', '<cmd>bnext<cr>', {desc='Buffer Next'})
vim.keymap.set('n', '<Leader>bp', '<cmd>bprev<cr>', {desc='Buffer Previous'})

vim.keymap.set({'n', 't'}, '<A-n>', '<cmd>bnext<cr>')
vim.keymap.set({'n', 't'}, '<A-p>', '<cmd>bprev<cr>')

-- Files
vim.keymap.set('n', '<Leader>ff', '<cmd>Pick files<cr>', {desc='Files Find'})
vim.keymap.set('n', '<Leader>fg', '<cmd>Pick grep_live<cr>', {desc='Files Grep'})

-- Terminals
-- TODO Replace with mini.terminals when that comes out
-- TODO Implement function to determine shell
vim.keymap.set('n', '<Leader>tn', '<cmd>term fish<cr>', {desc='Terminal New'})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Navigation
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l')

-- vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h')
-- vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j')
-- vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k')
-- vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l')

vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')


-- Keymap Hints
local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        { mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
        { mode = 'n', keys = '<Leader>f', desc = '+Files' },
        { mode = 'n', keys = '<Leader>t', desc = '+Terminals' },
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})

-- Completions
require('mini.completion').setup()

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

add({
    source = 'rafamadriz/friendly-snippets',
})

-- LSP
add({
    source = 'neovim/nvim-lspconfig',
})
