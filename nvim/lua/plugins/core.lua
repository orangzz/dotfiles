return {
	"tpope/vim-surround",
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"lewis6991/gitsigns.nvim",
			opts = {
				signs = { 
					change       = { text = '~' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆'}
				}
			},
	}
}
