return {
	"edkolev/tmuxline.vim",
	init = function()
		-- 1. Define your layout (as you did before)
		vim.g.tmuxline_preset = {
			a = "#S",
			win = "#W",
			cwin = "#W",
			-- x = "%a",
			-- y = "%Y-%m-%d %H:%M",
			-- z = " #h",
			options = {
				["status-justify"] = "left",
				["status-position"] = "top",
			},
		}
		vim.g.tmuxline_powerline_separators = 0
	end,
	config = function()
		local function simple()
			vim.g.tmuxline_theme = vim.g.simple_tmuxline_palette
		end

		local function catppuccin()
			local mocha = require("catppuccin.palettes").get_palette("latte")
			local fg = mocha.text
			local bg = mocha.base
			local visual = mocha.base

			local palette = {
				-- Left Side
				a = { fg, visual, "bold" }, -- Session: BG text on Brown
				b = { fg, visual }, -- Info: FG text on Visual Grey
				c = { fg, bg }, -- Main Bar: FG text on BG

				-- Right Side
				x = { fg, visual },
				y = { fg, visual },
				z = { fg, visual, "bold" }, -- Host: BG text on Brown

				-- Windows
				win = { fg, bg }, -- Inactive: Grey text on BG
				cwin = { bg, fg, "bold" }, -- Active: BG text on FG (Inverted)
				bg = { fg, bg },
			}

			vim.g.tmuxline_theme = palette
		end

		-- Everforest
		local function everforest()
			local bg_mode = vim.g.everforest_background or "dark"
			local colors_override = vim.g.everforest_colors_override or vim.empty_dict()

			local fn = vim.fn["everforest#get_palette"]
			local ok, palette = pcall(fn, bg_mode, colors_override)

			if ok and palette then
				local function get(name)
					return palette[name] and palette[name][1] or 0
				end

				-- Define the palette mappings
				local bg0 = get("bg0")
				local bg1 = get("bg1")
				local bg2 = get("bg2") -- Active/lighter background
				local fg = get("fg")
				local green = get("green")
				local grey = get("grey1")
				local blue = get("blue")

				vim.g.tmuxline_theme = {
					a = { bg2, green }, -- Active Session: Dark text on Green
					b = { green, bg2 }, -- Info: Green text on Lighter BG
					c = { grey, bg1 }, -- Rest of bar: Grey text on Dark BG
					x = { grey, bg1 }, -- (Same as c)
					y = { green, bg2 }, -- Date/Time
					z = { bg0, green }, -- Hostname
					win = { grey, bg1 }, -- Inactive Windows
					cwin = { bg0, green }, -- Active Window
					bg = { grey, bg0 }, -- Background fill
				}
			end
		end

		catppuccin()
	end,
}
