-- require("core")

-- configrations ------------------------------------------------
vim.opt.expandtab = false  -- use real tabs
vim.opt.tabstop = 4        -- a tab looks like 4 spaces
vim.opt.shiftwidth = 4     -- auto-indent uses 4 spaces (or one tab)
vim.opt.softtabstop = 0    -- pressing Tab inserts exactly one real tab
vim.g.mapleader = " "


-- packageManager Lazy.vim-----------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- lazy path

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)


-- plugins -------------------------------------------------------------------
local plugins = {	
	-- add your plugins here
	{
		"folke/tokyonight.nvim", 
		lazy = false, 
		priority = 1000
	},

	{
		'nvim-telescope/telescope.nvim', 
		tag = 'v0.2.0',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	{
		"nvim-treesitter/nvim-treesitter", 
		branch = 'master', 
		lazy = false, 
		build = ":TSUpdate"
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = 
			{
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-tree/nvim-web-devicons", -- optional, but recommended
			},

		lazy = false, -- neo-tree will lazily load itself
	}
}

local options = {	
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "tokyonight" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
} 


-- Setup -----------------------------------------------------------------------
require("lazy").setup(plugins, options)

local builtIn = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtIn.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtIn.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtIn.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtIn.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', {})
-- <C-W> <Left> or <Right> to move bettwen windows 

require("tokyonight").setup()
vim.cmd.colorscheme "tokyonight-night"


require('nvim-treesitter.configs').setup {
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { 
		"c", "lua", "vim", "vimdoc", 
		"query", "markdown", "markdown_inline", 
		"sql", "python", "cpp", "java", "javascript", 
		"html", "css", "kdl", "bash",
	},

	-- indent is by == 
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	indent = {enable = true},
	highlight = {enable = true}
}

