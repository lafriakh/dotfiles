return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local mode = vim.fn.system("defaults read -g AppleInterfaceStyle"):gsub("\n", "")

		if mode == "Dark" then
			vim.o.background = "dark"
			vim.cmd.colorscheme("catppuccin-mocha")
		else
			vim.o.background = "light"
			vim.cmd.colorscheme("catppuccin-latte")
		end

		-- vim.cmd.colorscheme("simple")
	end,
}

-- return {
-- 	"sainnhe/everforest",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		local mode = vim.fn.system("defaults read -g AppleInterfaceStyle"):gsub("\n", "")
--
-- 		if mode == "Dark" then
-- 			vim.opt.background = "dark"
-- 		else
-- 			vim.o.background = "light"
-- 		end
--
-- 		vim.cmd.colorscheme("simple")
--
-- 		-- vim.g.everforest_enable_italic = true
-- 		-- vim.opt.termguicolors = true
-- 		-- vim.g.everforest_background = 'hard'
-- 		-- vim.cmd.colorscheme("everforest")
-- 	end,
-- }
-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin-mocha")
-- 	end,
-- }
