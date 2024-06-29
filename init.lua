vim.g.mapleader = ','

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugin_treesitter = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp",
				"heex", "javascript", "html", "ruby" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
		})
	end
}

local plugin_telescope = {
	"nvim-telescope/telescope.nvim", tag = '0.1.6',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'BurntSushi/ripgrep',
	},
	config = function ()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	end
}


require("lazy").setup({
	plugin_treesitter,
	plugin_telescope,
})

-- Lua settings

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function(ev)
    vim.lsp.start({
      cmd = {'lua-language-server'},
    })
  end,
})

vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

