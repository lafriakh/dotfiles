return {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.background = 'light'
		vim.cmd.colorscheme("simple")

		-- vim.g.everforest_enable_italic = true
		-- vim.opt.termguicolors = true
		-- vim.g.everforest_background = 'hard'
		-- vim.cmd.colorscheme("everforest")
	end,
}
-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin-mocha")
-- 	end,
-- }
