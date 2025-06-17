return {
	{
		"folke/tokyonight.nvim",
		name="tokyonight",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				-- style = "storm",
				-- transparent = true,
				-- terminal_colors = true,
				styles = {
					comments = { italic = true  }, -- Change the style of comments
					conditionals = { italic = true  },
				},

			})
			vim.o.termguicolors = true
			vim.o.background = "dark"
			vim.cmd[[colorscheme tokyonight]]
		end,
	},
}

-- bg = u.vary_color(
-- 	{ mocha = u.lighten(colors.mantle, 0.74, colors.lavender) },
-- 	u.darken(colors.surface0, 0.64, colors.maroon)
-- ),

				-- custom_highlights = function()
				-- 	local u = require("catppuccin.utils.colors")
				-- 	return {
				-- 		CursorLineNr = { bg = u.blend(colors.overlay0, colors.base, 0.75), style = { "bold" } },
				-- 		CursorLine = { bg = u.blend(colors.overlay0, colors.base, 0.45) },
				-- 		LspReferenceText = { bg = colors.surface2 },
				-- 		LspReferenceWrite = { bg = colors.surface2 },
				-- 		LspReferenceRead = { bg = colors.surface2 },
				-- 	}
				-- end,
