-- Buffer-based file tree
return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(_, opts)
			require("oil").setup(opts)
			vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", { desc = "Open [O]il" })
		end,
	},
}
