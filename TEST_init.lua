-- NB: Many elements taken from kickstart.nvim

-- Make line numbers default
vim.opt.number = true

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Decrease update time
vim.opt.updatetime = 250

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.cmd([[
  augroup CppCommentStyle
    autocmd!
    autocmd FileType cpp,cc,cxx,cpp.h,cc.h,hh,hh.cxx setlocal commentstring=//\ %s
  augroup END
]])

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- require('lazy').setup({
--
--   'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
--
-- -- 	'nvim-telescope/telescope.nvim'
--
--   { -- Adds git related signs to the gutter, as well as utilities for managing changes
--     'lewis6991/gitsigns.nvim',
--     opts = {
--       signs = {
--         add = { text = '+' },
--         change = { text = '~' },
--         delete = { text = '_' },
--         topdelete = { text = '‾' },
--         changedelete = { text = '~' },
--       },
--     },
--   },
--
--   { -- Fuzzy Finder (files, lsp, etc)
--     'nvim-telescope/telescope.nvim',
--     event = 'VimEnter',
--     branch = '0.1.x',
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       { -- If encountering errors, see telescope-fzf-native README for installation instructions
--         'nvim-telescope/telescope-fzf-native.nvim',
--
--         -- `build` is used to run some command when the plugin is installed/updated.
--         -- This is only run then, not every time Neovim starts up.
--         build = 'make',
--
--         -- `cond` is a condition used to determine whether this plugin should be
--         -- installed and loaded.
--         cond = function()
--           return vim.fn.executable 'make' == 1
--         end,
--       },
--       { 'nvim-telescope/telescope-ui-select.nvim' },
--
--       -- Useful for getting pretty icons, but requires a Nerd Font.
--       { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
--     },
--     config = function()
--       -- Telescope is a fuzzy finder that comes with a lot of different things that
--       -- it can fuzzy find! It's more than just a "file finder", it can search
--       -- many different aspects of Neovim, your workspace, LSP, and more!
--       --
--       -- The easiest way to use Telescope, is to start by doing something like:
--       --  :Telescope help_tags
--       --
--       -- After running this command, a window will open up and you're able to
--       -- type in the prompt window. You'll see a list of `help_tags` options and
--       -- a corresponding preview of the help.
--       --
--       -- Two important keymaps to use while in Telescope are:
--       --  - Insert mode: <c-/>
--       --  - Normal mode: ?
--       --
--       -- This opens a window that shows you all of the keymaps for the current
--       -- Telescope picker. This is really useful to discover what Telescope can
--       -- do as well as how to actually do it!
--
--       -- [[ Configure Telescope ]]
--       -- See `:help telescope` and `:help telescope.setup()`
--       require('telescope').setup {
--         -- You can put your default mappings / updates / etc. in here
--         --  All the info you're looking for is in `:help telescope.setup()`
--         --
				-- defaults = {
				-- 	mappings = {
				-- 		i = { ["<c-j>"] = require('telescope.actions').move_selection_next,
                              -- ["<c-k>"] = require('telescope.actions').move_selection_previous},
				-- 	},
				-- },
--         --   mappings = {
--         --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
--         --   },
--         -- },
--         -- pickers = {}
--         extensions = {
--           ['ui-select'] = {
--             require('telescope.themes').get_dropdown(),
--           },
--         },
--       }
--
--       -- Enable Telescope extensions if they are installed
--       pcall(require('telescope').load_extension, 'fzf')
--       pcall(require('telescope').load_extension, 'ui-select')
--
--       -- See `:help telescope.builtin`
--       local builtin = require 'telescope.builtin'
--       vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
--       vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
--       vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
--       vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
--       vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
--       vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
--       vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
--       vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
--       vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
--       vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
--
--       -- Slightly advanced example of overriding default behavior and theme
--       vim.keymap.set('n', '<leader>/', function()
--         -- You can pass additional configuration to Telescope to change the theme, layout, etc.
--         builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--           winblend = 10,
--           previewer = false,
--         })
--       end, { desc = '[/] Fuzzily search in current buffer' })
--
--       -- It's also possible to pass additional configuration options.
--       --  See `:help telescope.builtin.live_grep()` for information about particular keys
--       vim.keymap.set('n', '<leader>s/', function()
--         builtin.live_grep {
--           grep_open_files = true,
--           prompt_title = 'Live Grep in Open Files',
--         }
--       end, { desc = '[S]earch [/] in Open Files' })
--
--       -- Shortcut for searching your Neovim configuration files
--       vim.keymap.set('n', '<leader>sn', function()
--         builtin.find_files { cwd = vim.fn.stdpath 'config' }
--       end, { desc = '[S]earch [N]eovim files' })
--     end,
--   },
--
-- })
