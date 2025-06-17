return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.keymap.set("n", "<Leader>er", "<Cmd>Neotree reveal right<CR>", { desc = "open explorer right" })
			vim.keymap.set("n", "<Leader>ne", "<Cmd>Neotree toggle<CR>", { desc = "toggle explorer" })
		end,
	},
}
