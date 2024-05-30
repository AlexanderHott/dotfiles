-- Colorscheme
return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- load this before all the other start plugins
		init = function()
			vim.cmd.colorscheme("tokyonight-night")
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
