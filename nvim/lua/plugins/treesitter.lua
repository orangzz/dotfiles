return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "windwp/nvim-ts-autotag" },
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"typescript",
					"tsx",
					"javascript",
					"lua",
					"go",
					"python",
					"astro",
					"prisma",
					"css",
					"html",
					"json",
					"markdown",
					"markdown_inline",
					"yaml",
					"toml",
					"vimdoc",
				},
				highlight = {
					enable = true,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					additional_vim_regex_highlighting = false,
				},
				autotag = { enable = true },
				indent ={ enable = true},
			})
		end,
	},
}
