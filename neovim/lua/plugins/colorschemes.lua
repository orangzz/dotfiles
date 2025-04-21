return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				styles = {
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
				},
				custom_highlights = function(colors)
					local u = require("catppuccin.utils.colors")
					return {
						CursorLineNr = { bg = u.blend(colors.overlay0, colors.base, 0.75), style = { "bold" } },
						CursorLine = { bg = u.blend(colors.overlay0, colors.base, 0.45) },
						LspReferenceText = { bg = colors.surface2 },
						LspReferenceWrite = { bg = colors.surface2 },
						LspReferenceRead = { bg = colors.surface2 },
					}
				end,
			})
			vim.o.termguicolors = true
			vim.cmd.colorscheme('catppuccin')
		end,
	},
}

-- bg = u.vary_color(
-- 	{ mocha = u.lighten(colors.mantle, 0.74, colors.lavender) },
-- 	u.darken(colors.surface0, 0.64, colors.maroon)
-- ),
