return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			default_component_configs = {
				container = {
					enable_character_fade = true,
					width = "100%",
					right_padding = 2,
				},
				indent = {
					padding = 1,
				},
			},
			window = {
				auto_expand_width = true,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["o"] = { "open", nowait = true },
					["oc"] = "none",
					["od"] = "none",
					["ob"] = "none",
					["om"] = "none",
					["on"] = "none",
					["os"] = "none",
					["ot"] = "none",
					["og"] = "none",
				},
			},
		})

		-- for revealing the floating Neotree
		vim.keymap.set({ "n", "i", "v" }, "<M-1>", ":Neotree filesystem toggle left<CR>", { desc = "Toggle Neo-tree" })
		vim.keymap.set({ "n", "i", "v" }, "<M-!>", ":Neotree reveal<CR>", { desc = "Reveal the current file Neo-tree" })
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>", { desc = "Reveal the floating Neotree" })
	end,
}
